require 'test_helper'

class HomeControllerTest < ActionController::TestCase
    
  test "guests should see a general introduction page" do
    @user = users(:cs)
    sign_in @user
    sign_out @user
    get :index
    assert_select 'h1.title', 'Welcome to Newsledge'  
  end
  
  test "logged in users should be redirected to their personalised home page" do 
    @user = users(:cs)
    sign_in @user
    get :index
    assert_redirected_to user_home_path
  end
end
