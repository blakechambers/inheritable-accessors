# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'inheritable_accessors/version'

Gem::Specification.new do |spec|
  spec.name          = "inheritable_accessors"
  spec.version       = InheritableAccessors::VERSION
  spec.authors       = ["Blake Chambers"]
  spec.email         = ["chambb1@gmail.com"]

  spec.summary       = %q{inheritable accessors}
  spec.description   = %q{inheritable accessors}
  spec.homepage      = "http://github.com/blakechambers/inheritable_accessors"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activesupport", ">= 3.2.0"
end
