class WelcomeController < ApplicationController
  before_action :set_session_filter, :only => [:home]
  
  def home
    if logged_in?
      @user = current_user
      redirect_to user_recipes_path(@user)
    else
      redirect_to login_path
    end
  end

  private
    def set_session_filter
      session[:filter_params] = {}
    end

end
