# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/medium/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-medium"
  spec.version       = OmniAuth::Medium::VERSION
  spec.authors       = ["Ross Penman"]
  spec.email         = ["ross@pen.mn"]

  spec.summary       = "OmniAuth strategy for the Medium API"
  spec.homepage      = "https://github.com/penman/omniauth-medium"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "omniauth-oauth2", "~> 1.0"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "dotenv"
end
