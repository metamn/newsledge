require 'test_helper'

class ReferencesControllerTest < ActionController::TestCase
  def setup
    @user = users(:other)
    sign_in @user
  end
  
  test "references must be associated to the current user (index)" do
    get :index
    assert_select 'td', {:value => 'reference_1', :count => 0}
  end
  
  test "references must be associated to the current user (show)" do
    get :show, :id => references(:one).id
    assert_redirected_to references_url
  end
  
  test "references cannot be added manually (new)" do
    get :new
    assert_redirected_to references_url
  end
  
  test "references are editable only be the owner (edit)" do
    get :edit, :id => references(:one).id
    assert_redirected_to references_url
  end
  
  test "references cannot be added manually (create)" do
    post :create
    assert_redirected_to references_url
  end
  
  test "references are editable only be the owner (update)" do
    put :update, :id => references(:one).id
    assert_redirected_to references_url
  end
  
  test "references are removable only be the owner (destroy)" do
    delete :destroy, :id => references(:one).id
    assert_redirected_to references_url
  end
   
  
  
  test "'New Item' link should not be shown on index page" do
    get :index
    assert_select 'a', {:value => 'New Item', :count => 0}
  end  
  
end
