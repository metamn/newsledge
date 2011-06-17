# Shared functionality available through all the application
#
# Authentication - all controllers are blocked by default. 
class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :authenticate_user!
end
