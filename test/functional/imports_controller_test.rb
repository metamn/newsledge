require 'test_helper'

class ImportsControllerTest < ActionController::TestCase
  
  def setup
    @user = users(:other)
    sign_in @user
    
    @account = accounts(:one)
  end
   
  test "user can see only it's own imports" do
    get :index
    assert_select 'td', {:text => 'import_1', :count => 0}
  end
  
  test "new imports are created through an account" do
    get :new, :account => @account.id
    assert_response :success
    assert_not_nil assigns(:account)
  end
  
  test "after creating an import a background job is started" do
    assert_difference('Import.count') do
      post :create, :import => { :account_id => @account.id }
    end 
    assert_redirected_to import_path(assigns(:import))
    assert_equal 'Importer started', flash[:notice]
  end
  
  test "imports cannot be edited" do
    get :edit, :id => imports(:one).id
    assert_redirected_to imports_path
  end
  
  test "on listing imports the 'Edit' button is not shown" do
    get :index
    assert_select 'a', {:text => 'Edit', :count => 0}
  end
  
  test "imports cannot be updated" do
    put :update, :id => imports(:one).id
    assert_redirected_to imports_path
  end
  
  test "imports cannot be deleted" do
    put :destroy, :id => imports(:one).id
    assert_redirected_to imports_path
  end
  
  test "on listing imports the 'Destroy' button is not shown" do
    get :index
    assert_select 'a', {:text => 'Destroy', :count => 0}
  end
  
  test "on listing imports the 'Show' button is not shown" do
    get :index
    assert_select 'a', {:text => 'Show', :count => 0}
  end
  
  test "on listing imports the 'New import' link is not shown" do
    get :index
    assert_select 'a', {:text => 'New import', :count => 0}
  end
end
