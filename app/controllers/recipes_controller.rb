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
    if @recipe = Recipe.create(recipe_params)
      redirect_to @recipe
    else
      render :new
    end

  end

  #show all recipes from all users or all recipes from single user
  def index
    if params[:user_id]
      @recipes = Recipe.where(:user_id => params[:user_id])
    else
      @recipes = Recipe.all
    end
  end

  #show all recipe ionformation
  def show
    @recipe = Recipe.find(params[:id])
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
      params.require(:recipe).permit(
        :user_id,
        :title, 
        :category_ids => [], 
        :categories_attributes => [:name], 
        :ingredient_ids => [], 
        :ingredients_attributes => [[:name], [:recipe_ingredients => [[:quantity],[:direction]]]]
        )
    end
end
