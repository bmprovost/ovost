# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ovost/version'

Gem::Specification.new do |spec|
  spec.name          = "ovost"
  spec.version       = '0.0.1'
  spec.authors       = ["Brian Provost"]
  spec.email         = ["brianmprovost@gmail.com"]
  spec.summary       = %q{A very simple URL shortener}
  spec.description   = %q{So far, just a Database, which is just a singleton class, and some methods to shorten links!}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14.1"
  spec.add_development_dependency "pry-debugger"
end
