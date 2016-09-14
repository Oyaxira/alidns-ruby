# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'alidns/version'

Gem::Specification.new do |spec|
  spec.name          = "alidns-ruby"
  spec.version       = Alidns::VERSION
  spec.authors       = ["luziyi"]
  spec.email         = ["292252585@qq.com"]

  spec.summary       = %q{alidns ruby sdk.}
  spec.description   = %q{a simple ruby sdk for alidns.}
  spec.homepage      = "http://oyaxira.com"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://rubygems.org'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency 'activesupport', '~> 4.2'
  spec.add_dependency 'rest-client', '~> 1.6'
  spec.add_dependency 'logging', '~> 2.0'
end