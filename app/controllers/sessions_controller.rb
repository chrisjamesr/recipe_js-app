class SessionsController < ApplicationController

  def new

  end

  def create
    if auth
      @user = User.find_by(:email => auth[:info][:email])
      if @user
        set_session
        redirect_to @user, :notice => "Welcome #{@user.name.capitalize}"
      else
        @user = User.create(:email => auth[:info][:email]) do |user|
          user.name = auth[:info][:name]
          user.password = Password.pronounceable(10) 
        end
        set_session
        redirect_to @user, :notice => "Welcome #{@user.name.capitalize}"
      end
    else
      @user = User.find_by(:name => params[:user][:name])
      if @user && @user.authenticate(params[:user][:password])
        set_session
        redirect_to @user, :notice => "Welcome #{@user.name.capitalize}"
      else
        flash[:alert] = @user.errors.full_messages
        render :new
      end
    end    
  end

  def destroy
    reset_session
    flash[:notice] = "You have been logged out!"
    redirect_to root_path
  end

  private
  def auth 
    request.env['omniauth.auth']
  end


end
