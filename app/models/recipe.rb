class Recipe < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :recipe_ingredients
  has_many :ingredients, :through => :recipe_ingredients

  validates :title, presence: true, allow_blank: false
  validates :category_id, presence: true, allow_blank: false

  # has_many :recipe_categories
  # has_many :categories, :through => :recipe_categories

  
end
