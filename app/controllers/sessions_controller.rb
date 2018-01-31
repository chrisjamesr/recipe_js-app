class SessionsController < ApplicationController

  def new

  end

  def create
    @user = User.find_by(:name => params[:user][:name])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to @user, :notice => "Welcome #{@user.name.capitalize}"
    else
      flash[:alert] = @user.errors.full_messages
      render :new
    end    
  end

  def destroy
    reset_session
    flash[:notice] = "You have been logged out!"
    redirect_to root_path
  end
end
