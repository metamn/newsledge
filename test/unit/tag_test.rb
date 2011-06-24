require 'test_helper'

class TagTest < ActiveSupport::TestCase
  should have_and_belong_to_many :items
  should belong_to :user
  should validate_uniqueness_of :name
end
