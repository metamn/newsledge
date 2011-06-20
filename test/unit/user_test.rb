require 'test_helper'

class UserTest < ActiveSupport::TestCase  
  should validate_presence_of :name
  should validate_uniqueness_of :name
  should have_many :accounts
  
  test "users are identified by :name instead of :id in the url" do
    @user = users(:other)
    assert_equal @user.to_param, @user.name    
  end
  
  test "should provide imports for user" do
    assert User.new.imports
  end
end
