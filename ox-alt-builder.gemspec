# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ox/alt_builder/version'

Gem::Specification.new do |gem|
  gem.name          = "ox-alt-builder"
  gem.version       = Ox::AltBuilder::VERSION
  gem.authors       = ["Daniel Vandersluis"]
  gem.email         = ["dvandersluis@selfmgmt.com"]

  gem.summary       = %q{DSL for easily building XML documents using ox}
  gem.homepage      = "https://www.github.com/dvandersluis/ox-builder"
  gem.license       = "MIT"

  gem.files         = Dir['{benchmark,lib}/**/*', 'Rakefile', 'README.md']
  gem.bindir        = "exe"
  gem.executables   = gem.files.grep(%r{^exe/}) { |f| File.basename(f) }
  gem.require_paths = ["lib"]

  gem.add_development_dependency "bundler", "~> 1.11"
  gem.add_development_dependency "rake", "~> 10.0"
  gem.add_development_dependency "rspec", "~> 3.0"
  gem.add_development_dependency 'actionpack', ['~> 3.2']
  gem.add_development_dependency 'activesupport', ['~> 3.2']
  gem.add_development_dependency 'tilt', ['~> 1.4']
  gem.add_development_dependency 'benchmark-ips'
  gem.add_development_dependency 'builder'

  gem.add_dependency 'ox'
  gem.add_dependency 'docile', ['~> 1.1.5']
end
