class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user



  def current_user
    @user = User.find_by(:id => session[:user_id]) unless nil
  end

  def logged_in?
    !!session[:user_id]
  end

  def set_session
    session[:user_id] = @user.id if @user
  end
end
