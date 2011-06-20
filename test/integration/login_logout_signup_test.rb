require 'integration_test_helper'

class LoginLogoutSignupTest < ActionDispatch::IntegrationTest
  fixtures :all

  test "users login via '/login'" do
    assert_routing '/login', {:controller => 'devise/sessions', :action => 'new'}
  end
  
  test "users logout via '/logout'" do
    assert_routing '/logout', {:controller => 'devise/sessions', :action => 'destroy'}
  end
  
  test "users sign up via '/register'" do
    assert_routing '/register', {:controller => 'devise/registrations', :action => 'new'}
  end
 
  test "user name is a valid route and points to user's homepage" do
    sign_in_as('coste', "coste.vincent@gmail.com", "monkey")
    assert page.has_content?('Signed in successfully'), "Signed in successfully"
    visit '/coste'
    assert page.has_content?('Dashboard'), "Dashboard"
  end
end
