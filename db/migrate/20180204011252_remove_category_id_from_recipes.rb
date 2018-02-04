class RemoveCategoryIdFromRecipes < ActiveRecord::Migration[5.1]
  def change
    remove_column :recipes, :category_id, :integer
  end
end
