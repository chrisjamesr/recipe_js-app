class SessionsController < ApplicationController

  def new

  end

  def create
    
  end

  def destroy
    reset_session
    flash[:notice] = "You have been logged out!"
    redirect_to root_path
  end
end
