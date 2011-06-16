require 'test_helper'

class PlatformsControllerTest < ActionController::TestCase
  test 'should get platforms' do
    get :index
    assert_response :success
    assert_not_nil assigns(:platforms)
  end
end
