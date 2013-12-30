# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'google_map_directions/version'

Gem::Specification.new do |spec|
  spec.name          = "google_map_directions"
  spec.version       = GoogleMapDirections::VERSION
  spec.authors       = ["Chris Hsu"]
  spec.email         = ["chris_h2312@yahoo.com"]
  spec.description   = %q{A wrapper gem for the google directions API}
  spec.summary       = %q{I'll update this once I have some working code.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
