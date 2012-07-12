module Doorway
  class Base
    Dir[File.join(File.dirname(__FILE__), "commands", "*.rb")].each do |f|
      command = File.basename(f)[/(.*)\.rb/, 1].camelize
      module_name = "Doorway::#{command}"
      self.send :include, module_name.constantize
    end

    attr_reader :conn

    def initialize(conn)
      @conn = conn
    end
  end
end