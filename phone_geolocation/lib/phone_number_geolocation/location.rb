class PhoneNumberGeolocation::Location
  include Mongoid::Document

  field :geo_name, type: String
  field :country, type: String
  field :phone_numbers, type: Array
  field :location, type: Array

  index(location: '2d', country: 1, geo_name: 1, phone_numbers: 1)

  validates :country, :location, presence: true

  scope :of_country, -> (country) { where(country: country) }

  def self.find_by_country_geo_name(country, geo_name = nil)
    scope = where(country: country)
    scope = scope.where(geo_name: geo_name) if geo_name.present?
    scope
  end
end
