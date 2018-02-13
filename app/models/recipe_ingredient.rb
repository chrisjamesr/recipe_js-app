class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient
  validate :recipe_ingredient_unique
  # validates :recipe_id, :ingredient_id, presence: true, allow_blank: false

  
  def recipe_ingredient_unique
    if RecipeIngredient.where(recipe_id: self.recipe_id, ingredient_id: self.ingredient_id).exists?
      self.errors[:base] << "This ingredient already exists"
    end
  end
end
