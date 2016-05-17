# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'phone_number_geolocation/version'

Gem::Specification.new do |spec|
  spec.name          = 'phone_number_geolocation'
  spec.version       = PhoneNumberGeolocation::VERSION
  spec.authors       = ['Ricardo Leitao']
  spec.email         = ['ricardo7rl@gmail.com']

  spec.summary       = 'Talkdesk challenge.'
  spec.description   = 'Talkdesk challenge.'
  spec.homepage      = 'https://github.com/Talkdesk/challenge_ricardoleitao'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = %w(phone_number_geo_match console populate_db)
  spec.require_paths = ['lib']

  spec.add_dependency 'geocoder'
  spec.add_dependency 'phonelib'
  spec.add_dependency 'mongoid', '~> 4.0.0.beta1'
  spec.add_dependency 'redis'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'pry'
end
