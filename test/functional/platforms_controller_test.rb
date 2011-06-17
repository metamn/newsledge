require 'test_helper'

class PlatformsControllerTest < ActionController::TestCase

  def setup
    @user = users(:other)
    sign_in @user
  end
  
  # Index
  #
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:platforms)
  end
  
  test "should list platforms starting with the title" do
    get :index
    assert_select 'h1.title', 'Platforms'
  end
  
  test "should call for the Add action (when there are no platforms added yet)" do
    get :index
    assert_select 'a', 'Suggest a new platform'
  end
  
  test "should list all platforms" do
    get :index
    assert_select "#items #name"
  end
  
  test "should show creation date of platform" do
    get :index
    assert_select "#items #date"
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
