require 'test_helper'

class UserTest < ActiveSupport::TestCase  
  should validate_presence_of :name
  should validate_uniqueness_of :name
  should have_many :accounts
  should have_many :items
  
  test "users are identified by :name instead of :id in the url" do
    @user = users(:other)
    assert_equal @user.to_param, @user.name    
  end
  
  test "should provide imports for user" do
    @user = users(:other)
    assert_not_nil @user.imports
  end
end
