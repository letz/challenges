# This class returns the nearest phone number given a target number
# and an list of possible phone numbers, with the option to search
# only in the same country of the target number
#
# @author letz
class PhoneNumberGeolocation::PhoneAssigner
  attr_reader :target_number, :customer_numbers, :same_country

  # PhoneAssigner initializer
  # @param [String] target phone number
  # @param [Array] list of possible phone numbers
  # @param [Boolean] flag to search only in the target phone country
  def initialize(target_number, customer_numbers, same_country = false)
    @target_number = target_number
    @customer_numbers = customer_numbers
    @same_country = same_country
  end

  # Find the closest phone number
  # @return [Array] with the phone number and the location of that number or
  #                 nil if doesn't find any match
  def find_closest
    find_target_coordinates
    location = build_query.geo_near(@target_cord).first

    return nil if location.nil?
    [(location.phone_numbers & customer_numbers).first, location.geo_name]
  end

  private

  # Find coordinates and country of target phone
  def find_target_coordinates
    number = Phonelib.parse(@target_number)
    @country = number.country
    @target_cord = PhoneNumberGeolocation::Location.find_by_country_geo_name(
      @country, number.geo_name
    ).first.location
  end

  # Query builder to find the location of possible phone numbers
  def build_query
    query = PhoneNumberGeolocation::Location.where(
      phone_numbers: { '$in' => customer_numbers }
    )
    query = query.of_country(@country) if same_country
    query
  end
end
