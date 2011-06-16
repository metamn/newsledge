class PlatformsController < ApplicationController

  def index
    @platforms = Platform.all
  end
  
  def new
    @platform = Platform.new  
  end
  
  def create
    @platform = Platform.new(params[:platform])
    
    if @platform.save
      redirect_to platforms_url, notice: 'Platform was successfully created.'
    else
      render action: "new"
    end
  end
  
  
end
