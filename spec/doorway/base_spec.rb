require 'spec_helper'

describe Doorway::Base do
  let(:ssh) { stub(:ssh) }

  subject { Doorway::Base.new(ssh) }

  its(:conn) { should == ssh }

  describe "includes" do
    it "includes all commands" do
      subject.should be_kind_of(Doorway::Exec)
      subject.should be_kind_of(Doorway::ExecAs)
      subject.should be_kind_of(Doorway::RemoteFile)
    end
  end
end