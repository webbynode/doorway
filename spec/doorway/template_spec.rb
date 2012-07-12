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

  describe '#create_from_template' do
    before do
      subject.stub(:write_file)
    end

    it "compiles the template" do
      subject.should_receive(:compile_template).with('template', {})
      subject.create_from_template 'file', 'template'
    end

    it "writes the file with compiled template" do
      subject.stub(:compile_template => 'contents')
      subject.should_receive(:write_file).with('file', 'contents')
      subject.create_from_template 'file', 'template'
    end
  end

  describe '#write_file' do
    it "writes the file" do
      file = stub(:file)
      File.should_receive(:open).with('file', 'w+').and_yield(file)
      file.should_receive(:write).with('contents')
      subject.write_file 'file', 'contents'
    end
  end

  describe "#temp_from_template" do
    let(:tmp) { stub(:tmp).as_null_object }

    before do
      subject.stub(:compile_template => 'contents')
      Tempfile.stub(:new => tmp)
    end

    it "creates a tempfile" do
      Tempfile.should_receive(:new).with("doorway").and_return(tmp)
      expect(subject.temp_from_template("template", :a => :b)).to eql(tmp)
    end

    it "compiles the template" do
      subject.should_receive(:compile_template).with("template", :a => :b).
        and_return("temp_contents")
      subject.temp_from_template("template", :a => :b)
    end

    it "writes the result of the template to the tempfile" do
      tmp.should_receive(:write).with('contents')
      subject.temp_from_template("template", :a => :b)
    end
  end
end