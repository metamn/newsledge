require 'test_helper'

class AccountsControllerTest < ActionController::TestCase

  def setup
    @user = users(:other)
    sign_in @user    
  end  
  
  test "user can see only it's own accounts" do
    get :index
    assert_select 'td', {:text => 'account_1', :count => 0}
  end
  
  test "accounts must show their import history via AJAX" do
    get :imports, :id => accounts(:two).id, :format => :js
    assert_response :success
  end
end
