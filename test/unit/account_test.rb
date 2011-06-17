require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  test "should belong to an user" do
    @user = users(:other)
    assert @user.accounts
  end
  
  test "should belong to a platform" do
    @account = accounts(:one)
    assert @account.platform
  end
  
  test "should have a unique name" do
    a1 = Account.new :name => 'test1'
    a1.save
    a2 = Account.new :name => 'test1'
    assert !a2.save
  end
end
