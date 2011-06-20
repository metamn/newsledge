require 'test_helper'
require 'capybara/rails'


module ActionController
  class IntegrationTest
    include Capybara

    def sign_in_as(name, user, password)
       user = User.create(:name => name, :password => password, :password_confirmation => password, :email => user)
       user.save!
       visit '/login'
       fill_in 'Email', :with => user.email
       fill_in 'Password', :with => password
       click_link_or_button('Sign in')
       user      
     end 
     def sign_out
        click_link_or_button('Log Out')   
     end
  end
end

