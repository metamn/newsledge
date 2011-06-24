require 'test_helper'

class TagsControllerTest < ActionController::TestCase
  def setup
    @user = users(:other)
    sign_in @user
  end
  
  test "tags must be associated to the current user (index)" do
    get :index
    assert_select 'td', {:value => 'tag_1', :count => 0}
  end
  
  test "tags must be associated to the current user (show)" do
    get :show, :id => tags(:one).id
    assert_redirected_to tags_url
  end
  
  test "tags cannot be added manually (new)" do
    get :new
    assert_redirected_to tags_url
  end
  
  test "tags are editable only be the owner (edit)" do
    get :edit, :id => tags(:one).id
    assert_redirected_to tags_url
  end
  
  test "tags cannot be added manually (create)" do
    post :create
    assert_redirected_to tags_url
  end
  
  test "tags are editable only be the owner (update)" do
    put :update, :id => tags(:one).id
    assert_redirected_to tags_url
  end
  
  test "tags are removable only be the owner (destroy)" do
    delete :destroy, :id => tags(:one).id
    assert_redirected_to tags_url
  end
   
  
  
  test "'New Item' link should not be shown on index page" do
    get :index
    assert_select 'a', {:value => 'New Item', :count => 0}
  end  
  
end
