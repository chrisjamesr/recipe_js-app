module RecipeHelper

  def recipe_new_or_edit(recipe)
    recipe.new_record? ? recipe.ingredients.build : recipe.ingredients
  end
end
