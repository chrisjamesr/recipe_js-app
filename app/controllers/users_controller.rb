class UsersController < ApplicationController

  def new

  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user), :notice => "Welcome #{@user.name.capitalize}" 
      session[:user_id] = @user.id
    else
      render :new
    end

  end

  def show

  end

  private

  def user_params
    params.require(:user).permit(:name, :password)
  end


  
end
