require 'spec_helper'

describe PhoneNumberGeolocation::ArgumentsValidator do
  let(:target_number) { '+12018840000' }
  let(:customer_numbers) { %w(+15148710000 +14159690000) }

  context 'given args array with flag, a target phone and 2 customer numbers' do
    let(:flag) { '--same-country-only' }
    let(:args) { %W(#{flag} #{target_number}) + customer_numbers }

    subject(:subject) { described_class.new(*args) }

    it 'detects the flag' do
      expect(subject.same_country?).to be_truthy
    end

    it 'detects the target phone' do
      expect(subject.target_number).to eq(target_number)
    end

    it 'detects the 2 customer numbers' do
      expect(subject.customer_numbers).to eq(customer_numbers)
    end

    context 'and there is two invalid number' do
      let(:invalid) { %w(+351oops not_this) }
      let(:args) { %W(#{flag} #{target_number}) + customer_numbers + invalid }

      subject(:subject) { described_class.new(*args) }

      it 'rejects the invalid number' do
        expect(subject.customer_numbers).to match_array(customer_numbers)
      end
    end
  end

  context 'given args array with a target phone and 2 customer numbers' do
    let(:args) { [target_number] + customer_numbers }

    subject(:subject) { described_class.new(*args) }

    it 'does not detect the flag' do
      expect(subject.same_country?).to be_falsey
    end

    it 'detects the target phone' do
      expect(subject.target_number).to eq(target_number)
    end

    it 'detects the 2 customer numbers' do
      expect(subject.customer_numbers).to eq(customer_numbers)
    end

    context 'and there is two invalid number' do
      let(:invalid) { %w(+351oops not_this) }
      let(:args) { [target_number] + customer_numbers + invalid }

      subject(:subject) { described_class.new(*args) }

      it 'rejects the invalid number' do
        expect(subject.customer_numbers).to match_array(customer_numbers)
      end
    end
  end
end
