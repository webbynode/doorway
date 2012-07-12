require 'ostruct'
require 'tempfile'

module Template
  def asset(name)
    File.expand_path("../../../assets/#{name}", __FILE__)
  end

  def compile_template(template, vars)
    contents = File.read asset(template)
    struct = ErbBinding.new(vars)
    ERB.new(contents).result(struct.send(:get_binding))
  end

  def create_from_template(file, template, vars={})
    write_file file, compile_template(template, vars)
  end

  def temp_from_template(template, vars={})
    tmp = Tempfile.new("doorway")
    tmp.write compile_template(template, vars)
  end

  def write_file(file, contents)
    File.open(file, 'w+') { |f| f.write contents }
  end
end

class ErbBinding < OpenStruct
  def get_binding
    binding
  end
end
