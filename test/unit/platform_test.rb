require 'test_helper'

class PlatformTest < ActiveSupport::TestCase
  should validate_uniqueness_of :name
  should have_many :accounts
end
