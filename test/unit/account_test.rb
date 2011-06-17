require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  test "name must be unique" do
    unique Account, :name
  end
  
  test "account must be associated to users" do
    belongs_to Account, :user, users(:other)
  end
  
  test "account must be associated to platforms" do
    belongs_to Account, :platform, platforms(:one)
  end
  
  should have_many(:imports)
end
