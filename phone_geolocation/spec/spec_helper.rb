$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

ENV['MONGOID_ENV'] = 'test'

require 'pry'
require 'phone_number_geolocation'
