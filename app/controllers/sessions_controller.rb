class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    # raise params.inspect
    if params[:user][:name].present? && params[:user][:password].present? 
      @user = User.find_by(:name => params[:user][:name])
      if @user && @user.authenticate(params[:user][:password])
        set_session
        redirect_to @user, :notice => "Welcome #{@user.name.capitalize}"
      else
        set_errors(params)
        render :new
      end
    elsif auth.present?
      @user = User.login_from_omniauth(auth)
      set_session
      redirect_to @user, :notice => "Welcome #{@user.name.capitalize}"
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
    flash.now[:alert] = {:name => "Name Required"} if params[:user][:name].nil?
    flash.now[:alert] = {:name => "User Not Found"} if User.find_by(:name => params[:user][:name]).nil?
    flash.now[:alert] = {:password => "Password Required"} if params[:user][:password].nil?
    flash.now[:alert] = {:password => "Password incorrect"} if @user && !@user.authenticate(params[:user][:password])

  end


end
