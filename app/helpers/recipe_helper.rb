module RecipeHelper

  def recipe_new_or_edit(recipe)
    if recipe.new_record? 
      4.times {recipe.ingredients.build}
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

  def order_options
    {
      "Longest" => :longest,
      "Shortest" => :shortest, 
      "Newest" => :newest,
      "Oldest" => :oldest
    }
  end

  def no_recipes 
    content_tag(:div, "No Recipes", :class => "no-recipes")
  end
end  # End of
