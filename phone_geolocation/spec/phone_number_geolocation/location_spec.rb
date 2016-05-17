require 'spec_helper'

describe PhoneNumberGeolocation::Location do
  context 'given a Location without field location' do
    subject(:subject) { described_class.new(country: 'PT', geo_name: 'Lisbon') }

    it 'is invalid' do
      expect(subject).to be_invalid
    end
  end

  context 'given a Location without field country' do
    subject(:subject) do
      described_class.new(geo_name: 'Lisbon', location: [1, 1])
    end

    it 'is invalid' do
      expect(subject).to be_invalid
    end
  end

  context 'given a Location with all fields' do
    subject(:subject) do
      described_class.new(country: 'PT', geo_name: 'Lisbon', location: [1, 1])
    end

    it 'is valid' do
      expect(subject).to be_valid
    end
  end
end
