# Shared functionality available through all the application
#
# Authentication - all controllers are blocked by default. 
# Authorization / Data Ownership - only current user can access its own data. 
# Otherwise an ActiveRecord::RecordNotFound exception is raised and catched here
class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :authenticate_user!
  
  rescue_from ActiveRecord::RecordNotFound, :with => :not_authorized
  
  private
    
    # Catching non-authorized data lookups
    def not_authorized
      flash[:notice] = "Invalid request."
      redirect_to :controller => params[:controller], :action => :index
    end
end
