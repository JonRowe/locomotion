# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'locomotion/version'

Gem::Specification.new do |spec|
  spec.name          = "locomotion"
  spec.version       = Locomotion::VERSION
  spec.authors       = ["Jon Rowe"]
  spec.email         = ["hello@jonrowe.co.uk"]
  spec.description   = %q{Geolocation library for RubyMotion}
  spec.summary       = %q{Geolocation library for RubyMotion}
  spec.homepage      = "https://github.com/JonRowe/locomotion"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec|app)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
