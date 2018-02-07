module RecipeIngredientsHelper

  def recipe_ingredient_new_or_edit(recipe, ingredient)
    if recipe.new_record? 
      recipe.recipe_ingredients.build 
    else recipe_ingredient = recipe.recipe_ingredients.find_by(:recipe_id => recipe.id, :ingredient_id => ingredient.id)
      recipe_ingredient
    end
  end
  
end  # End of Class