class ChangeDirectionColumnInRecipeIngredientsTable < ActiveRecord::Migration[5.1]
  def change
    remove_column :recipe_ingredients, :direction, :string
    add_column :recipe_ingredients, :preparation, :string
  end
end
