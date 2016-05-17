require 'phone_number_geolocation/version'
require 'mongoid'
require 'redis'
require 'geocoder'
require 'phonelib'

require 'phone_number_geolocation/location'
require 'phone_number_geolocation/arguments_validator'
require 'phone_number_geolocation/phone_assigner'

env = ENV['MONGOID_ENV'].nil? ? :development : ENV['MONGOID_ENV'].to_sym
Mongoid.load!('config/mongoid.yml', env)
Geocoder.configure(cache: Redis.new)

module PhoneNumberGeolocation
  # Your code goes here...
end
