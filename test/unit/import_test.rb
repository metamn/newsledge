require 'test_helper'

class ImportTest < ActiveSupport::TestCase
  test "imports are associated to accounts" do
    belongs_to Import, :account, accounts(:one)
  end
end
