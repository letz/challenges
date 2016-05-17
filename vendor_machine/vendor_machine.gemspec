lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vendor_machine/version'

Gem::Specification.new do |spec|
  spec.name          = 'vendor_machine'
  spec.version       = VendorMachine::VERSION
  spec.authors       = ['Ricardo Leitão']
  spec.email         = ['rleitao@onliquid.com']

  spec.summary       = 'Onfido Challenge'
  spec.description   = 'Onfido Challenge'
  spec.homepage      = 'https://github.com/letz/onfido-challenge'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'bin'
  spec.executables   = 'console'
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'
end
