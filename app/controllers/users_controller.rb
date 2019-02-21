class UsersController < ApplicationController
  before_action :current_user, :only => [:show] 
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save 
      set_session
      redirect_to recipes_path, :notice => "Welcome #{@user.username}" 
    else      
      render :new
    end
  end

  def index
    # render json: User.all, response: 200
    # respond_to do |format|
    #   format.html { render layout: false}
    #   format.json { render json: User.all,  status: 200}
    # end
    redirect_to recipes_path
  end
  
  def show
    @recipes = @user.recipes
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end  
end
