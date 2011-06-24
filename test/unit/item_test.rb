require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  should belong_to :account
  should belong_to :user
  should have_and_belong_to_many :tags
end
