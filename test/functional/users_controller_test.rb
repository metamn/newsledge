require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get home" do
    @user = users(:other)
    sign_in @user
    get :home
    assert_response :success
  end

end
