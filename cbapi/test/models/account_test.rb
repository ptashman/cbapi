require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  test "accounts with past due balances should be delinquent" do
    a = Account.create(name: "DelinquentAccount1", due_date: DateTime.now-200)
    assert Account.delinquent.include?(a)
  end

  test "nondelinquent accounts should not be sent to collections" do
    assert_raise(NoMethodError) { Account.all.send_to_collections }
  end

  test "delinquent accounts should be sent to collections" do
    a = Account.create(name: "DelinquentAccount2", due_date: DateTime.now-200, in_collections: false)
    assert_difference 'Account.where(in_collections: true).count', 1 do
      Account.delinquent.send_to_collections
    end
  end

  test "accounts which have spent more than a million should be top performing" do
    a = Account.create(name: "TopPerformingAccount", total_spent: 1000000000)
    assert Account.top_performing.include?(a)
  end
end
