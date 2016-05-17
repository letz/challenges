class VendorMachine::Machine
  attr_reader :items

  def initialize
    @items = {}
    @calculator = VendorMachine::Calculator.new
  end

  # ------------------
  # Service Operations
  # ------------------

  # Add Items to the machine
  # @param [VendorMachine::Item] item to add
  def add_item(item)
    @items[item.name] ||= []
    @items[item.name] << item
  end

  # Add coin for changes
  # @param [Float] value of the coin
  def add_money(value)
    @calculator.add_money value
  end

  # See the money inside the machine
  def money
    @calculator.amount
  end

  # ---------------
  # User operations
  # ---------------

  # Buy item based on previous money inserted
  # @param [String] item name
  def buy_item(name)
    change = @calculator.buy @items[name].last
    [@items[name].pop, change]
  end

  # Returns an item
  # @param [String] name of the item to show
  def show_item(name)
    @items[name].first
  end

  # Count items by name
  # @param [String] name of the item
  def count_items(name)
    @items[name].size
  end

  # Insert coins to buy items
  # @param [Float] value of the coin
  def put_coin(value)
    @calculator.add_pending value
  end

  # Returns the amount of coins inserted by the user
  def pending_amount
    @calculator.pending_amount
  end

  # Retrive the coins inserted by the user
  def cancel
    @calculator.retrieve_pending_amount
  end
end
