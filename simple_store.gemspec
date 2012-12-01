# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_store/version'

Gem::Specification.new do |gem|
  gem.name          = "simple_store"
  gem.version       = SimpleStore::VERSION
  gem.authors       = ["Kris Leech"]
  gem.email         = ["kris.leech@gmail.com"]
  gem.description   = %q{Store buckets of keyed hashes in memory or to disk, useful for testing without a real database}
  gem.summary       = %q{Store buckets of keyed hashes in memory or to disk}
  gem.homepage      = "https://github.com/krisleech/simple_store"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rspec'
end
