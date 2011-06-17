require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  def setup
    @user = users(:other)
    sign_in @user
  end
  
  # Index
  #
  test "should get index" do
    index :accounts
  end
  
  test "should list accounts starting with the title" do
    title 'Accounts'
  end
  
  test "should notice if there are no accounts yet" do
    not_found @accounts  
  end
    
  test "should list name" do
    list "name"
  end
  
  test "should list platform" do
    list "platform"
  end
end
