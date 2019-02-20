class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    if auth.present?
      @user = User.login_from_omniauth(auth)
      set_session
      redirect_to user_recipes_path(@user), :notice => "Welcome #{@user.username.capitalize}"
    elsif params[:user][:email].present? && params[:user][:password].present? 
      @user = User.find_by(:email => params[:user][:email])
      if @user && @user.authenticate(params[:user][:password])
        set_session
        redirect_to user_recipes_path(@user), :notice => "Welcome #{@user.username.capitalize}"
      else
        set_errors(params)
        render :new
      end
    else
      set_errors(params)
      render :new
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

  def set_errors(params)

    flash.now[:alert] = {:email => "Email Required"} if params[:user][:email].nil?
    flash.now[:alert] = {:email => "User Not Found"} if User.find_by(:email => params[:user][:email]).nil?
    flash.now[:alert] = {:password => "Password Required"} if params[:user][:password].nil?
    flash.now[:alert] = {:password => "Password incorrect"} if @user && !@user.authenticate(params[:user][:password])

  end


end
