class VendorMachine::NotEnoughMoney < StandardError
end

class VendorMachine::NoChangeNoAvailable < StandardError
end

class VendorMachine::InvalidCoin < StandardError
end
