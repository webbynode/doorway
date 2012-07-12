require 'shared/command_context'
require './lib/doorway/commands/exec_as'

describe ExecAs do
  include_context "command"

  before { include_commands_from ExecAs }

  it "executes the command as the user" do
    expected_command = %Q[sudo -i -u git bash -c "/etc/init.d/nginx stop"]
    subject.should_receive(:exec).with(expected_command)
    subject.exec_as :git, "/etc/init.d/nginx stop"
  end

  it "escapes double quotes" do
    expected_command = %q[sudo -i -u git bash -c "echo \"something\" > ~/.bashrc"]
    subject.should_receive(:exec).with(expected_command)
    subject.exec_as :git, 'echo "something" > ~/.bashrc'
  end

  it "escapes dollar signs" do
    expected_command = %q[sudo -i -u git bash -c "PATH=\$HOME/bin:\$PATH"]
    subject.should_receive(:exec).with(expected_command)
    subject.exec_as :git, 'PATH=$HOME/bin:$PATH'
  end
end