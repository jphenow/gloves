# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gloves/version'

Gem::Specification.new do |spec|
  spec.name          = "gloves"
  spec.version       = Gloves::VERSION
  spec.authors       = ["Jon Phenow"]
  spec.email         = ["j.phenow@gmail.com"]
  spec.summary       = %q{A framework for writing beautiful Alfred workflows}
  spec.description   = %q{}
  spec.homepage      = "http://github.com/jphenow/gloves"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1.0"
  spec.add_development_dependency "codeclimate-test-reporter"

  spec.add_dependency "plist", "~> 3.1.0"
  spec.add_dependency "alfred-workflow", "~> 2.0.5"
end
