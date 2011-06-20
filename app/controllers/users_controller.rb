class UsersController < ApplicationController
  
  def show
    @user = User.find_by_name(params[:id])
    redirect_to root_path if @user.blank? || @user.name != current_user.name
  end

end
