class ChangeDescriptionColumnInRecipesTable < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :directions, :text
  end
end
