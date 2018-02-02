class RecipesController < ApplicationController

  def new
    if !logged_in?  
      redirect_to root_path
    elsif logged_in? && current_user == User.find(params[:user_id])
      @recipe = Recipe.new(:user => current_user)
    else
      @recipe = Recipe.new(:user => current_user)
      redirect_to new_user_recipe_path(current_user)
    end
  end

  def create
    raise params.inspect
    @recipe = current_user.recipe.build()
  end

  #show all recipes from all users or all recipes from single user
  def index

  end

  #show all recipe ionformation
  def show

  end

  def edit

  end

# protected methods
  def update

  end

  def destroy

  end

  private
    def recipe_params
      recipe.require(:recipe).permit(:name, :category_id, :ingredient_attributes)
    end
end
