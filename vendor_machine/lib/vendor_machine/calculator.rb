class VendorMachine::Calculator
  COIN_MAPPER = { '0.01' => 0, '0.02' => 0, '0.05' => 0, '0.1' => 0,
                  '0.2' => 0, '0.5' => 0, '1.0' => 0, '2.0' => 0 }
  VALUES_IN_CENTS = COIN_MAPPER.keys.map { |v| (v.to_f * 100).to_i }.reverse

  attr_reader :pending_amount, :amount

  def initialize
    @money = COIN_MAPPER.dup
    @pending_money = COIN_MAPPER.dup
    @pending_amount = 0
    @amount = 0
  end

  # Add money on temporary state
  # @param [Float] value of the coin
  # @raise [VendorMachine::InvalidCoin] if the coin is invalid
  def add_pending(value)
    raise_invalid_coin! if @pending_money[value.to_s].nil?
    @pending_money[value.to_s] += 1
    update_pending
  end

  # Add money to the machine
  # @param [Float] value of the coin
  # @raise [VendorMachine::NotEnoughMoney] the temporary money isn't enough to
  #        buy the product
  def add_money(value)
    raise_invalid_coin! if @money[value.to_s].nil?
    @money[value.to_s] += 1
    update_money
  end

  # Checks if the money on temporary state is enough to buy the item, and return
  # the change (if needed)
  # @param [VendorMachine::Item] item to buy
  # @raise [VendorMachine::InvalidCoin] if the coin is invalid
  def buy(item)
    raise_no_money! if item.price > pending_amount
    change = calc_change(pending_amount - item.price)
    transfer_pending_to_money
    remove_from_money change
    change
  end

  # Return the money in temporary state
  def retrieve_pending_amount
    change = @pending_money.dup
    @pending_money = COIN_MAPPER.dup
    change
  end

  private

  # Calculate the change to return based on the value of the product using the
  # available money
  # @param [Float] amount of money to return to the user
  # @raise [VendorMachine::NoChangeNoAvailable] the machine does not have the coins
  #        to return change
  def calc_change(amount)
    remaining_amount = (amount * 100).round(2).to_i
    change = COIN_MAPPER.dup
    VALUES_IN_CENTS.each do |value|
      number_coins = remaining_amount / value
      next if number_coins == 0
      string_coin = (value / 100.to_f).to_s
      raise_no_change_available! if @money[string_coin] - number_coins < 0
      change[string_coin] += number_coins
      remaining_amount -= number_coins * value
    end
    change
  end

  # Transfer money from pending state to the money of the machine
  def transfer_pending_to_money
    @pending_money.each do |coin, value|
      @money[coin] += value
      @pending_money[coin] = 0
    end
    update_pending
    update_money
  end

  # Remove coins from the machine (used to retrive the change)
  def remove_from_money(rem_money)
    rem_money.each do |coin, value|
      @money[coin] -= value
    end
    update_money
  end

  # Update the cache of the temporary money
  def update_pending
    @pending_amount = self.class.count_money @pending_money
  end

  # Update the cache of the machine money
  def update_money
    @amount = self.class.count_money @money
  end

  def self.count_money(money)
    sum_amount = 0
    money.each do |value, i|
      sum_amount += value.to_f * i
    end
    sum_amount.round(2)
  end

  def raise_no_change_available!
    fail VendorMachine::NoChangeNoAvailable, 'No change available'
  end

  def raise_no_money!
    fail VendorMachine::NotEnoughMoney, 'Insuficient Money'
  end

  def raise_invalid_coin!
    fail VendorMachine::InvalidCoin
  end
end
