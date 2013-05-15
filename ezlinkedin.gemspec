# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ezlinkedin/version'

Gem::Specification.new do |spec|
  spec.name          = "ezlinkedin"
  spec.version       = Ezlinkedin::VERSION
  spec.authors       = ["akonwi"]
  spec.email         = ["akonwi@gmail.com"]
  spec.description   = "A simple way to make calls on Linkedin's API"
  spec.summary       = %q{It uses oauth access_tokens}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

	spec.add_runtime_dependency 'oauth', '~> 0.4.7'
	spec.add_runtime_dependency 'hashie', '~> 2.0.5'
	spec.add_runtime_dependency 'json', '~> 1.8.0'
	spec.add_runtime_dependency 'multi_json', '~> 1.7.3'
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", '~> 2.6'
  spec.add_development_dependency "webmock", '~> 1.11.0'
end
