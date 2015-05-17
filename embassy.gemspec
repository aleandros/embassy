# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'embassy/version'

Gem::Specification.new do |spec|
  spec.name          = "embassy"
  spec.version       = Embassy::VERSION
  spec.authors       = ["Edgar Cabrera"]
  spec.email         = ["ecabrera@intelimetrica.com"]
  spec.summary       = %q{System for simulating and validating APIs}
  spec.description   = %q{Embassy is a system for describing JSON APIs via YAML files, which can then serve as a simualtion for the client, or as validation for the server}
  spec.homepage      = "https://github.com/aleandros/embassy"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest-reporters", "~> 1.0"
  spec.add_development_dependency "rack-test", '~> 0.6'
  spec.add_development_dependency "guard", '~> 2.12.5'
  spec.add_development_dependency "guard-minitest", '~> 2.4.4'

  spec.add_runtime_dependency 'sinatra', '~> 1.4'
  spec.add_runtime_dependency 'sinatra-contrib', '~> 1.4'
end
