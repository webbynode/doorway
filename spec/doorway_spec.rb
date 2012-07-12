require './lib/doorway'
require './lib/doorway/base'

describe Doorway do
  let(:ssh)       { stub(:ssh)  }
  let(:ssh_conn)  { stub(:ssh_conn) }
  let(:conn)      { stub(:conn) }

  subject { Doorway }

  before do
    stub_const("Net::SSH", ssh)
    Net::SSH.stub(:start => ssh_conn)
  end

  describe "#connect" do
    it "creates a new SSH connection" do
      Net::SSH.should_receive(:start).with("host", "root", hash_including(
        :password => "password",
        :port     => 389
      ))
      subject.connect(:root, "host", :password => "password", :port => 389)
    end

    it "creates a new connection" do
      Doorway::Base.should_receive(:new).with(ssh_conn).and_return(conn)
      subject.connect(:root, "host")
    end

    it "yields the connection if block given" do
      yielded = false
      subject.connect(:root, "host") do |conn|
        yielded = conn.is_a?(Doorway::Base)
      end
      fail "block not raised or connection not of expected type" unless yielded
    end
  end
end