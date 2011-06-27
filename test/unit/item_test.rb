require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  should belong_to :account
  should belong_to :user
  should have_and_belong_to_many :tags
  should have_and_belong_to_many :references
  
  test "should save Twitter items" do
    pending
  end
  
  test "should not call more than 150 times / hour the Twitter API" do
    pending
  end
  
  test "getting the latest tweets should be done manually on the UI" do
    pending
  end
  
  test "getting the latest tweets should be limited based on the Twitter API calls remained / hour" do
    pending
  end
end
