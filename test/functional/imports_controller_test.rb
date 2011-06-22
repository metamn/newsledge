require 'test_helper'

class ImportsControllerTest < ActionController::TestCase
  
  def setup
    @user = users(:other)
    sign_in @user
  end
   
  test "user can see only it's own imports" do
    get :index
    assert_select 'td', {:text => 'import_1', :count => 0}
  end
  
  test "new imports are created through and account" do
    @account = accounts(:one)
    get :new, :account => @account.id
    assert_response :success
    assert_not_nil assigns(:account)
  end
end
