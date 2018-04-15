require('minitest/autorun')
require_relative('../customer.rb')

class TestCustomer < MiniTest::Test


def setup
  @customer = Customer.new("tom", 20)
end


end
