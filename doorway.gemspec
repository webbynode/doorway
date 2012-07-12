# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "doorway/version"

Gem::Specification.new do |s|
  s.name          = "doorway"
  s.version       = Doorway::Version::STRING
  s.authors       = ["Felipe Coury"]
  s.email         = ["felipe.coury@gmail.com"]
  s.homepage      = "http://github.com/webbynode/doorway"
  s.summary       = "Sane set of utility methods to provision remote servers over SSH and SCP."
  s.description   = s.summary

  s.add_development_dependency "rspec"          , "~> 2.11"

  s.files         = `git ls-files`.split($\)
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]
end
