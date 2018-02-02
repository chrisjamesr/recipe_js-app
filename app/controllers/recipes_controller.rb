class RecipesController < ApplicationController

  def new

  end

  def create
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
