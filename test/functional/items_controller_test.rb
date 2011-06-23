require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  
  def setup
    @user = users(:other)
    sign_in @user
  end
    
  test "items must be associated to the current user (index)" do
    get :index
    assert_select 'td', {:value => 'item_1', :count => 0}
  end
  
  test "items must be associated to the current user (show)" do
    get :show, :id => items(:one).id
    assert_redirected_to items_url
  end
  
  test "items are editable only be the owner (edit)" do
    get :edit, :id => items(:one).id
    assert_redirected_to items_url
  end
  
  test "items are editable only be the owner (update)" do
    put :update, :id => items(:one).id
    assert_redirected_to items_url
  end
  
  test "items are removable only be the owner (destroy)" do
    delete :destroy, :id => items(:one).id
    assert_redirected_to items_url
  end
  
  test "items cannot be added manually (new)" do
    get :new
    assert_redirected_to items_url
  end
  
  test "items cannot be added manually (create)" do
    post :create
    assert_redirected_to items_url
  end
  
  test "'New Item' link should not be shown on index page" do
    get :index
    assert_select 'a', {:value => 'New Item', :count => 0}
  end  
end
