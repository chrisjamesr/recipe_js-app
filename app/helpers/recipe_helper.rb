module RecipeHelper

  def recipe_new_or_edit(recipe)
    recipe.new_record? ? recipe.ingredients.build : recipe.ingredients
  end

  def show_edit_and_delete_buttons
    if current_user == User.find(params[:user_id])
      link_to "Edit", edit_user_recipe_path(current_user, Recipe.find(params[:id]))
      # button_to "Delete", user_recipe_path(current_user, Recipe.find(params[:id])), :method => "delete"
    end
  end
end  # End of
