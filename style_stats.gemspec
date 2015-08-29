# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'style_stats/version'

Gem::Specification.new do |spec|
  spec.name          = "style_stats"
  spec.version       = StyleStats::VERSION
  spec.authors       = ["shiro16"]
  spec.email         = ["nyanyanyawan24@gmail.com"]

  spec.summary       = %q{StyleStats is a library to collect CSS statistics!}
  spec.description   = %q{Oriainal StyleStats is a Node.js library to collect CSS statistics! This gem was port in Ruby}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'oga'
  spec.add_runtime_dependency 'css_parser'
  spec.add_runtime_dependency 'command_line_reporter'

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
