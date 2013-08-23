# encoding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "presentation"
  spec.version       = "0.1.0"
  spec.authors       = ["Andrew Havens"]
  spec.email         = ["email@andrewhavens.com"]
  spec.description   = %q{Create fullscreen presentations using Ruby.}
  spec.summary       = %q{Create fullscreen presentations using Ruby.}
  spec.homepage      = "https://github.com/andrewhavens/presentation"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
  spec.add_dependency "gosu"
  spec.add_dependency "coderay"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
