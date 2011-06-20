require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = users(:other)
    sign_in @user    
  end
  
  test "user's can't see each others page" do
    @user2 = users(:cs)
    get :show, :id => @user2.name
    assert_redirected_to root_path
  end
  
  test "invalid user name will redirect to root page" do
    get :show, :id => 'random'
    assert_redirected_to root_path
  end
  
end
