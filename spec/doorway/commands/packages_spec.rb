require 'spec_helper'

describe Doorway::Packages do
  include_context "command"

  before do
    include_commands_from Doorway::Packages
    subject.stub(:exec_as)
  end

  describe "#update_packages" do
    it "updates the package list" do
      subject.should_receive(:exec_as).with(:root, "apt-get update")
      subject.update_packages
    end
  end

  describe "#install" do
    it "installs a package" do
      subject.should_receive(:exec_as).
        with(:root, 
          "DEBIAN_FRONTEND=noninteractive apt-get install -y -q package")
      subject.install "package"
    end
  end

  describe "#add_ppa" do
    before do
      subject.stub(:update_packages)
    end

    it "executes the command as the default user" do
      subject.should_receive(:exec_as).with(:root, "add-apt-repository ppa:ppa")
      subject.add_ppa "ppa"
    end

    it "updates the packages" do
      subject.should_receive(:update_packages)      
      subject.add_ppa "ppa"
    end
  end
end
