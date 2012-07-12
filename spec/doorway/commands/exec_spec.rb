require 'shared/command_context'
require './lib/doorway/commands/exec'

describe Exec do
  include_context "command"

  before { include_commands_from Exec }

  it "executes the command as the default user" do
    conn.should_receive(:exec!).with("command")
    subject.exec "command"
  end
end
