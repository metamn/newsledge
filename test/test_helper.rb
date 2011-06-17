ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  fixtures :all
 
 
  # belongs_to
  def belongs_to(table, field, value)
    item = table.new field.to_sym => value
    assert item.save
  end
 
  # validates uniqueness of
  def unique(table, field)
    i1 = table.new field.to_sym => 'test1'
    i1.save
    i2 = table.new field.to_sym => 'test1'
    assert !i2.save, "#{field} must be unique"
  end  
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

