require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  should belong_to :account
  should belong_to :user
end
