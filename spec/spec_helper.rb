require "bundler"
Bundler.setup(:default, :development)
Bundler.require(:default, :development)

require "doorway"

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|file| require file}
