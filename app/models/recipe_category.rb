class RecipeCategory < ApplicationRecord
  belongs_to :category
  belongs_to :recipe
  validate :recipe_category_unique
  # validates :recipe_id, :ingredient_id, presence: true, allow_blank: false

  
  def recipe_category_unique
    if RecipeCategory.where(recipe_id: self.recipe_id, category_id: self.category_id).exists? && self.new_record?
      self.errors[:base] << "This association already exists"
    end
  end
end
