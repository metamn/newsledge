require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  def setup
    @user = users(:other)
    sign_in @user    
  end
    
  test "guests should see a general introduction page" do
    sign_out @user
    get :index
    assert_select 'h1.title', 'Welcome to Newsledge'  
  end
  
  test "logged in users see a link to their personalised home page" do 
    get :index
    assert_select 'a', 'View your page'
  end  
  
end
