require 'spec_helper'

describe Doorway::Get do
  include_context "command"

  before { include_commands_from Doorway::Get }

  describe "#get" do
    it "goes to the destination folder" do
      subject.should_receive(:exec).with(/cd \/usr\/local\/src/)
      subject.get "http://nginx.org/download/nginx-1.2.2.tar.gz", 
        "/usr/local/src"
    end

    it "downloads the file using wget" do
      subject.should_receive(:exec).
        with(/wget -q http:\/\/nginx.org\/download\/nginx-1.2.2.tar.gz/)
      subject.get "http://nginx.org/download/nginx-1.2.2.tar.gz", 
        "/usr/local/src"
    end

    it "saves to the indicated file when save_as is passed" do
      subject.should_receive(:exec).
        with(/wget -q -O hello.txt http:\/\/helloworld.org\/file.txt/)
      subject.get "http://helloworld.org/file.txt", "/tmp", "hello.txt"
    end
  end
end
