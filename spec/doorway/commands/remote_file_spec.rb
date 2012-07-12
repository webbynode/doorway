require 'spec_helper'

describe Doorway::RemoteFile do
  include_context "command"

  before do
    include_commands_from Doorway::RemoteFile
  end
  
  context "with a local file" do
    it "uploads the file" do
      scp.should_receive(:upload!).with('local', 'remote')
      subject.remote_file 'remote', 'local'
    end
  end

  context "with a template" do
    before do
      subject.stub(:temp_from_template => '/dir/temp')
    end

    it "creates a tempfile from the template" do
      subject.should_receive(:temp_from_template).
        with('nginx/vhost.conf.erb', hash_including(
          :server   => 'www.example.org',
          :root     => '/var/www/example'
        )).
        and_return('/path/to/temp')

      subject.remote_file '/etc/nginx/conf.d/site.conf', 
        :template => 'nginx/vhost.conf.erb',
        :server   => 'www.example.org',
        :root     => '/var/www/example'
    end

    it "uploads the tempfile" do
      scp.should_receive(:upload!).with('/dir/temp', 
        '/etc/nginx/conf.d/site.conf')

      subject.remote_file '/etc/nginx/conf.d/site.conf', 
        :template => 'nginx/vhost.conf.erb',
        :server   => 'www.example.org',
        :root     => '/var/www/example'      
    end
  end

  context "with no template or local file" do
    it "raises an error" do
      expect do
        subject.remote_file('file', :a => :b)
      end.to raise_error
    end
  end
end
