# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "devtools/version"

Gem::Specification.new do |spec|
  spec.name    = "devtools"
  spec.version = DevTools::VERSION
  spec.authors = ["Donovan Young"]
  spec.email   = ["dyoung522@gmail.com"]

  spec.summary     = %q{Miscellaneous utilities to make a developers life easier}
  spec.description = %q{Utilities include:\nRunTest - Runs specs based on local configuration} +
    %q{\nRunEnv  - Run the dev environment based on local configuration}
  spec.homepage    = "https://github.com/dyoung522/devtools"
  spec.license     = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "config", "~> 1.3"

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.4"
end
