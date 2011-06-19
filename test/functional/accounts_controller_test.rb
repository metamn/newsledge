require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  
  test "user can see only it's own accounts" do
    sign_in users(:cs)
    get :index
    assert_select 'td', {:text => 'account2', :count => 0}
  end
  
  test "accounts must show their import history" do
    @user = users(:other)
    sign_in @user
    get :index
    assert_select 'a', 'Imports'
  end
end
