module RecipeIngredientsHelper

  def recipe_ingredient_new_or_edit(recipe, ingredient)
    if recipe.new_record? 
      recipe.recipe_ingredients.build 
    elsif recipe_ingredient = recipe.recipe_ingredients.find_by(:recipe_id => recipe.id, :ingredient_id => ingredient.id)
      recipe_ingredient
    elsif recipe.persisted? && recipe.recipe_ingredients.empty?
      recipe_ingredient = RecipeIngredient.new(:recipe_id => recipe.id)
    end
  end
  
  def remove_recipe_ingredient(recipe_ingredient_object)
    if request.parameters[:action] == "edit" && @recipe.recipe_ingredients.present?
      link_to "x", remove_ingredient_path(recipe_ingredient_object), :method => "delete"
    end
  end

end  # End of Class