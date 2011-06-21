require 'integration_test_helper'

class ResqueTest < ActionDispatch::IntegrationTest
  fixtures :all

  test "Resque admin interface must be mounted to '/resque'" do
    #sign_in_as('coste', "coste.vincent@gmail.com", "monkey")
    #assert page.has_content?('Signed in successfully'), "Signed in successfully"
    visit '/resque'
    assert page.has_content?('Queues'), "/resque was not found"    
  end
end
