require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test "user should have accounts" do
    @user = users(:other)
    assert @user.accounts
  end
end
