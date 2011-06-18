class ImportsController < ApplicationController
  def index
    @imports = current_user.accounts.map {|a| a.imports}.flatten
  end

  def start
  end

  def stop
  end

  def show
  end

end
