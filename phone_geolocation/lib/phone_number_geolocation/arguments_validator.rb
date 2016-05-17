# This class parses and validates arguments passed in the exe file
#
# @author letz
class PhoneNumberGeolocation::ArgumentsValidator
  SAME_COUNTRY_FLAG = '--same-country-only'

  attr_reader :target_number, :customer_numbers

  def initialize(*args)
    @same_country = args[0] == SAME_COUNTRY_FLAG
    @target_number = same_country? ? args[1] : args[0]
    @customer_numbers = same_country? ? args.slice(2..-1) : args.slice(1..-1)

    reject_invalid_numbers
  end

  # Checks if the arguments passed includes the flag
  # @return [Boolean] true if the flag is present, false otherwise
  def same_country?
    @same_country
  end

  private

  # Reject invalid phone numbers
  def reject_invalid_numbers
    @customer_numbers.reject! { |num| !Phonelib.valid?(num) }
  end
end
