# -*- encoding: utf-8 -*-
require File.expand_path('../lib/justdial/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["MavenHive Team"]
  gem.email         = ["dev@mavenhive.in"]
  gem.description   = %q{Ruby JustDial API client}
  gem.summary       = %q{Ruby JustDial API client}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "justdial-ruby"
  gem.require_paths = ["lib"]
  gem.version       = Justdial::VERSION

  gem.add_runtime_dependency(%q<rest-client>)
  gem.add_runtime_dependency(%q<json>)
end
