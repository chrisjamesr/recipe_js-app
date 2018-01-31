class Recipe < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :recipe_ingredients
  has_many :ingredients, :through => :recipe_ingredients

  # has_many :recipe_categories
  # has_many :categories, :through => :recipe_categories

  
end
