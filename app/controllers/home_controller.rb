# The default landing page for non-logged in visitors
#
# - users logged in are routed to their personalised home page
# - otherwise all controller actions are freely browsable without authentication
class HomeController < ApplicationController
  skip_before_filter :authenticate_user!
  
  def index
    redirect_to user_home_url unless current_user.blank?
  end
end
