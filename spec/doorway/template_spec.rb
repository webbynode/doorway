require './lib/doorway/template'

describe Template do
  subject { Class.new { include Template }.new }

  describe "#asset" do
    it "maps to the template path" do
      expected = File.expand_path("../../../assets/path/file", __FILE__)
      expect(subject.asset("path/file")).to eql(expected)
    end
  end

  describe '#compile_template' do
    it "returns the string for the template" do
      asset = subject.asset('vhosts/nginx/rails3.erb')
      File.should_receive(:read).with(asset).
        and_return('abcdef <%= app.name %> <%= app.path %>')

      app = stub(
        :name    => 'app1',
        :path    => '/var/app/app1',
        :domain  => 'webby.com',
        :alaises => 'app2.webby.com app3.webby.com'
      )
      
      result = subject.compile_template('vhosts/nginx/rails3.erb', 
        { :app => app })
      result.should == "abcdef app1 /var/app/app1"
    end
  end
end