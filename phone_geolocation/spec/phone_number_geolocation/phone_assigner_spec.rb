require 'spec_helper'

describe PhoneNumberGeolocation::PhoneAssigner do
  before :all do
    `populate_db` # Hack to not use factory girl
  end

  context 'given a call to New Jersey' do
    let(:new_jersey) { '+12018840000' }
    let(:available_numbers) { %w(+15148710000 +14159690000) }

    it 'returns the number +15148710000 (Montreal)' do
      expect(
        described_class.new(new_jersey, available_numbers).find_closest
      ).to eq %w(+15148710000 Montreal,QC)
    end

    context 'and with same country rule' do
      it 'return the number +14159690000 San Francisco' do
        expect(
          described_class.new(new_jersey, available_numbers, true).find_closest
        ).to eq %w(+14159690000 California)
      end
    end
  end

  context 'given a call to Setubal' do
    let(:setubal) { '+351265120000' }
    let(:available_numbers) { %w(+351211230000 +351222220000) }

    it 'returns the number +351211230000 Lisbon' do
      expect(
        described_class.new(setubal, available_numbers).find_closest
      ).to eq %w(+351211230000 Lisbon)
    end
  end

  context 'given a call to France' do
    let(:france) { '+33975180000' }
    let(:available_numbers) { %w(+441732600000 +14159690000) }

    it 'returns the number +441732600000 Sevenoaks' do
      expect(
        described_class.new(france, available_numbers).find_closest
      ).to eq %w(+441732600000 Sevenoaks)
    end

    context 'and with same country rule' do
      it 'returns nil' do
        expect(
          described_class.new(france, available_numbers, true).find_closest
        ).to be_nil
      end
    end
  end
end
