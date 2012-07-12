require 'shared/command_context'
require './lib/doorway/commands/remote_file'

describe RemoteFile do
  include_context "command"

  before do
    include_commands_from RemoteFile
  end
  
  it "uploads the file" do
    scp.should_receive(:upload!).with('local', 'remote')
    subject.remote_file 'remote', 'local'
  end

  it "compiles the ERB template" do
    subject.should_receive(:compile_template).
      with('nginx/vhost.conf.erb', hash_including(
        :server   => 'www.example.org',
        :root     => '/var/www/example'
      )).
      and_return('template_contents')

    subject.remote_file '/etc/nginx/conf.d/site.conf', 
      :template => 'nginx/vhost.conf.erb',
      :server   => 'www.example.org',
      :root     => '/var/www/example'
  end
end
