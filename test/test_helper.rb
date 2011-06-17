ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...  
end

class ActionController::TestCase
  include Devise::TestHelpers
  
  # Checks if index is rendered together with the collection to be shown
  def index(collection)
    get :index
    assert_response :success
    assert_not_nil assigns(collection.to_sym)
  end
  
  # Checks if index has a title
  def title(t)
    get :index
    assert_select 'h1.title', t
  end
  
  # Checks if the field is listed 
  def list(field)
    get :index
    assert_select "#items #" + field
  end
  
  def not_found(collection)
    collection = []
    get :index
    assert_select '#not_found .notice'
  end
end

