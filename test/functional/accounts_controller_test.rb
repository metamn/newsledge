require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  test "user can see only it's own accounts" do
    a1 = users(:cs).accounts.map {|a| a.id}
    a2 = users(:other).accounts.map {|a| a.id}
    assert (a1 & a2 == [])
  end
end
