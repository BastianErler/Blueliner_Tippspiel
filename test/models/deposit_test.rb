require 'test_helper'

class DepositTest < ActiveSupport::TestCase
  test "should not save deposits without a user_id" do
    deposit = Deposit.new(amount: 10.00)
    assert_not deposit.save
  end
  test "should not save deposits without an amount" do
    deposit = Deposit.new(user_id: 1)
    assert_not deposit.save
  end
end
