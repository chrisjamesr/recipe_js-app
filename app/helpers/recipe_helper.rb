module RecipeHelper

  def recipe_new_or_edit(recipe)
    if recipe.new_record? 
      6.times {recipe.ingredients.build}
    elsif recipe.persisted? && recipe.ingredients.empty?
     recipe.ingredients.build
    else 
      recipe.ingredients 
    end 
  end

  def show_edit_link
    if current_user == User.find(params[:user_id])
      link_to "Edit", edit_user_recipe_path(current_user, Recipe.find(params[:id]))
      # button_to "Delete", user_recipe_path(current_user, Recipe.find(params[:id])), :method => "delete"
    end
  end
end  # End of
