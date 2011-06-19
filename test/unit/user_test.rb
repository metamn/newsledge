require 'test_helper'

class UserTest < ActiveSupport::TestCase  
  should have_many :accounts
  
  test "should provide imports for user" do
    assert User.new.imports
  end
end
