module Template
  def asset(name)
    File.expand_path("../../../assets/#{name}", __FILE__)
  end

  def compile_template(template, vars)
    contents = File.read asset(template)
    struct = ErbBinding.new(vars)
    ERB.new(contents).result(struct.send(:get_binding))
  end
end

require 'ostruct'

class ErbBinding < OpenStruct
  def get_binding
    binding
  end
end
