ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'shoulda/rails'


class ActiveSupport::TestCase
  fixtures :all
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


class ActionController::IntegrationTest
  include Devise::TestHelpers
  fixtures :all
end


# Turning off deprecation warnings in the autotest output
module ActiveSupport
  module Deprecation
    class << self
      def warn(message = nil, callstack = caller)
        # modif pvh the following lines make sure no deprecation warnings are sent 
        # for code that is
        # not by my but in some gem or plugin...
        return if silenced  || callstack.grep(/myrailsappname/).blank?
        # return if silenced 
        deprecation_message(callstack, message).tap do |m|
          behavior.each { |b| b.call(m, callstack) }
        end
      end
    end
  end
end  
