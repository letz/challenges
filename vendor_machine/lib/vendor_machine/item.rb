# This class represents an vendor machine item
class VendorMachine::Item
  attr_accessor :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end
