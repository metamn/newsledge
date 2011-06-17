require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  should validate_uniqueness_of :name
  
  should belong_to :user  
  should belong_to :platform  
  should have_many :imports
end
