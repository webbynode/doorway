require "active_support/core_ext/string/inflections"
require "net/ssh"

module Doorway
  autoload :Version, "doorway/version"
  autoload :Base, "doorway/base"

  Dir[File.join(File.dirname(__FILE__), "doorway", "commands", "*.rb")].each do |f| 
    require f
  end

  def self.connect(user, host, options={})
    ssh  = Net::SSH.start(host, user.to_s, options)
    conn = Doorway::Base.new(ssh)

    yield conn if block_given?

    conn
  end
end
