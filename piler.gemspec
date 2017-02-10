# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'piler/version'

Gem::Specification.new do |spec|
  spec.name          = "piler"
  spec.version       = Piler::VERSION
  spec.authors       = ["meganemura"]
  spec.email         = ["meganemura@users.noreply.github.com"]

  spec.summary       = "Utility for managing GitHub Project's cards"
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/meganemura/piler"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "octokit"
  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
