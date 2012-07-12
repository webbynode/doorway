shared_context "command" do
  let(:conn) { stub(:conn).as_null_object }
  let(:scp)  { stub(:scp).as_null_object  }

  class Subject; end

  subject do
    Subject.new
  end

  def include_commands_from(base)
    Subject.send :include, base
  end

  before do
    subject.stub(:conn => conn)
    conn.stub(:scp => scp)
  end
end