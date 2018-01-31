class AddCategoryIdToRecipes < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :category_id, :integer
  end
end
