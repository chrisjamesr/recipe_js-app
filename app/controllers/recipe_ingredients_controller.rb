class RecipeIngredientsController < ApplicationController
  before_action :current_user
  
  def create

  end

  def destroy    
    @recipe_ingredient = RecipeIngredient.find(params[:id])
    @recipe = @recipe_ingredient.recipe
    @recipe_ingredient.destroy
    respond_to do |format|
      format.html { render edit_user_recipe_path(@recipe.user.id, @recipe.id)}
      format.json { render json: @recipe_ingredient,  status: 200}
    end
  end


end
