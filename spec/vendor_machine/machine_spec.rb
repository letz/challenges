require 'spec_helper'

describe VendorMachine::Machine do
  describe 'given on pending amount of 0.84 and 0.16 of money' do
    before do
      subject.put_coin 0.5
      subject.put_coin 0.2
      subject.put_coin 0.1
      subject.put_coin 0.02
      subject.put_coin 0.02

      subject.add_money 0.1
      subject.add_money 0.02
      subject.add_money 0.02
      subject.add_money 0.02
    end

    context 'and tries to buy one item of 1.0' do
      let(:item) { VendorMachine::Item.new('item', 1.0) }
      before do
        subject.add_item item
      end

      it 'raises not enough money' do
        expect {
          subject.buy_item item.name
        }.to raise_error VendorMachine::NotEnoughMoney
      end

      it 'doesnt remove the item from the vending machine' do
        expect {
          subject.buy_item(item.name) rescue nil
        }.not_to change { subject.count_items item.name }.from(1)
      end

      it 'the machine money does not change' do
        expect {
          subject.buy_item(item.name) rescue nil
        }.not_to change { subject.money }.from(0.16)
      end

      it 'the machine pending amount does not change' do
        expect {
          subject.buy_item(item.name) rescue nil
        }.not_to change { subject.pending_amount }.from(0.84)
      end
    end

    context 'and tries to buy one item of 0.79' do
      let(:item) { VendorMachine::Item.new('item', 0.79) }
      before do
        subject.add_item item
      end

      it 'raises no change available' do
        expect {
          subject.buy_item item.name
        }.to raise_error VendorMachine::NoChangeNoAvailable
      end

      it 'doesnt remove the item from the vending machine' do
        expect {
          subject.buy_item(item.name) rescue nil
        }.not_to change { subject.count_items item.name }.from(1)
      end

      it 'the machine money does not change' do
        expect {
          subject.buy_item(item.name) rescue nil
        }.not_to change { subject.money }.from(0.16)
      end

      it 'the machine pending amount does not change' do
        expect {
          subject.buy_item(item.name) rescue nil
        }.not_to change { subject.pending_amount }.from(0.84)
      end
    end

    context 'and tries to buy one item of 0.8' do
      let(:item) { VendorMachine::Item.new('item', 0.8) }
      before do
        subject.add_item item
      end

      it 'removes the item from the vending machine' do
        expect {
          subject.buy_item item.name
        }.to change { subject.count_items item.name }.from(1).to(0)
      end

      it 'returns a change of two coins of 0.02 cents' do
        expect(subject.buy_item item.name).to eq([item, { "0.01" => 0, "0.02" => 2, "0.05" => 0, "0.1" => 0, "0.2" => 0, "0.5" => 0, "1.0" => 0, "2.0" => 0}])
      end

      it 'the machine amount raises to 0.96' do
        expect {
          subject.buy_item item.name
        }.to change { subject.money }.from(0.16).to(0.96)
      end

      it 'resets the pending amount' do
        expect {
          subject.buy_item item.name
        }.to change { subject.pending_amount }.from(0.84).to(0)
      end
    end
  end
end
