class UsersController < ApplicationController
  before_action :current_user, :only => [:show] 
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save 
      set_session
      redirect_to recipes_path, :notice => "Welcome #{@user.username.capitalize}" 
    else      
      render :new
    end
  end

  def index
    render json: User.all, response: 200
  end
  
  def show
    @recipes = @user.recipes
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end  
end
