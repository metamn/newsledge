require 'test_helper'

class PlatformsControllerTest < ActionController::TestCase

  def setup
    @user = users(:other)
    sign_in @user
  end
  
  # Index
  #
  test "should get index" do
    index :platforms
  end
  
  test "should list platforms starting with the title" do
    title 'Platforms'
  end
  
  test "should notice if there are no platforms yet" do
    #not_found @platforms  
  end
  
  test "should list all platforms" do
    list "name"
  end
  
  test "should show creation date of platform" do
    list "date"
  end
  
  # Add
  #
  test "should create platform" do
    assert_difference('Platform.count') do
      post :create, :platform => { :name => 'test'}
    end   
    assert_redirected_to platforms_path
  end
  
  test "should have a form creating a new platform" do
    post :new
    assert_select 'h1.title', 'Suggest a new platform'
  end
  
  
end
