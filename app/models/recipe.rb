class Recipe < ApplicationRecord
  belongs_to :user

  has_many :recipe_ingredients
  has_many :ingredients, :through => :recipe_ingredients

  validates :title, presence: true, allow_blank: false
  validates :category_id, presence: true, allow_blank: false

  belongs_to :category
  has_many :recipe_categories
  has_many :categories, :through => :recipe_categories

  def ingredient_attributes

  end
end
