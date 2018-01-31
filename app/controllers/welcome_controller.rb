class WelcomeController < ApplicationController
  
  def home
    if logged_in?
      @user = current_user
      redirect_to user_path(@user)
    end
  end
end
