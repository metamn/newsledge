require 'test_helper'

class PlatformTest < ActiveSupport::TestCase
  test "should have a Platform table" do
    platform = Platform.new
    assert_instance_of Platform, platform
  end
  
  test "should have a name field" do
    platform = Platform.new :name => 'test'
    assert_equal platform.name, 'test'
  end
  
  test "should have a description field" do
    platform = Platform.new :description => 'description'
    assert_equal platform.description, 'description'
  end
  
  test "name should be unique" do
    p1 = Platform.new( :name => 'test').save
    p2 = Platform.new( :name => 'test')
    assert !p2.save, "name should be unique"
  end
  
  test "should have a status with [suggested, working on, active]" do
    pending
  end
end
