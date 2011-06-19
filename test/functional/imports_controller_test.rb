require 'test_helper'

class ImportsControllerTest < ActionController::TestCase
  
  def setup
    @user = users(:other)
    sign_in @user
  end
  
  test "index must respond to AJAX calls" do
    get :index, :format => :js
    assert_response :success
  end
 
  test "user can see only it's own imports" do
    get :index
    assert_select 'td', {:text => 'import_1', :count => 0}
  end
end
