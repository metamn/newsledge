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
  
  test "after creating an import a background job is started" do
    assert_difference('Import.count') do
      post :create, :import => { :account_id => accounts(:one).id }
    end 
    assert_redirected_to import_path(assigns(:import))
    assert_equal 'Importer started', flash[:notice]
  end
end
