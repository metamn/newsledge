require 'test_helper'

class UserTest < ActiveSupport::TestCase  
  should validate_presence_of :name
  should validate_uniqueness_of :name
  should have_many :accounts
  should have_many :items
  should have_many :tags
  
  def setup
    @user = users(:other)
  end
  
  test "users are identified by :name instead of :id in the url" do
    assert_equal @user.to_param, @user.name    
  end
  
  test "should provide imports for user" do
    assert_not_nil @user.imports
  end
  
  test "should provide a single import for user" do
    assert_not_nil @user.import imports(:two)
  end
  
end
