require './lib/doorway/commands/exec'

describe Exec do
  let(:conn) { stub(:conn) }

  subject do
    Class.new { include Exec }.new
  end
  
  before do
    subject.stub(:conn => conn)
  end

  it "executes the command as the default user" do
    conn.should_receive(:exec!).with("command")
    subject.exec "command"
  end
end