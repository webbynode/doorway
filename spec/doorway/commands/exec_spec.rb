require 'spec_helper'

describe Doorway::Exec do
  include_context "command"

  before { include_commands_from Doorway::Exec }

  it "executes the command as the default user" do
    conn.should_receive(:exec!).with("command")
    subject.exec "command"
  end
end
