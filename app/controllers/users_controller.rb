class UsersController < ApplicationController
  before_action :current_user, :only => [:show] 
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save 
      set_session
      redirect_to user_path(@user), :notice => "Welcome #{@user.name.capitalize}" 
    else      
      flash[:alert] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @recipes = @user.recipes
  end

  private

  def user_params
    params.require(:user).permit(:name, :password)
  end


  
end
