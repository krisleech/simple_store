# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_store/version'

Gem::Specification.new do |gem|
  gem.name          = "simple_store"
  gem.version       = SimpleStore::VERSION
  gem.authors       = ["Kris Leech"]
  gem.email         = ["kris.leech@gmail.com"]
  gem.description   = %q{A memory and file backed data store for attributes}
  gem.summary       = %q{}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rspec'
end
