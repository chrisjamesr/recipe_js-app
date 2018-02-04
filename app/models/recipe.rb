class Recipe < ApplicationRecord
  belongs_to :user

  has_many :recipe_ingredients
  has_many :ingredients, :through => :recipe_ingredients

  validates :title, presence: true, allow_blank: false
  validates :title, uniqueness: true
  

  # belongs_to :category
  has_many :recipe_categories
  has_many :categories, :through => :recipe_categories

  def ingredients_attributes=(ingredients_attributes)

    ingredients_attributes.each do |i, ingredient_attribute|
      if ingredient_attribute.present?
        ingredient = self.ingredients.build(:name => ingredient_attribute[:name]) 
        if !self.ingredients.include?(ingredient)
          self.recipe_ingredients.build(
            :ingredient => ingredient,
            :quantity => ingredient_attribute[:recipe_ingredients][:quantity], 
            :direction => ingredient_attribute[:recipe_ingredients][:direction]
            )          
        end
      end
    end    
  end

  def categories_attributes=(categories_attributes)
    categories_attributes.each do |i, category_attribute|
      if category_attribute.present?
        category = Category.find_or_create_by(category_attribute)
        if self.categories.include?(category)
          self.recipe_categories.build(:category => category)
        end
      end
    end
  end

end
