class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients, :dependent => :destroy
  has_many :ingredients, :through => :recipe_ingredients
  has_many :recipe_categories
  has_many :categories, :through => :recipe_categories

  validates :title, :description, :directions, presence: true, allow_blank: false
  validates :title, :uniqueness => {:case_sensitive => false}

  scope :by_ingredient,  ->(ingredient_id) {
    joins(:recipe_ingredients)
    .where("recipe_ingredients.ingredient_id = ?", ingredient_id)
  }
  scope :by_category, ->(category_id) {
    joins(:recipe_categories)
    .where("recipe_categories.category_id = ?", category_id)
  }
  scope :newest, -> {order(:created_at => :desc)}
  scope :oldest, -> {order(:created_at => :asc)}

  def ingredients_attributes=(ingredients_attributes)
    ingredients_attributes.each do |i, ingredient_attribute|
      if ingredient_attribute.present?
        ingredient = Ingredient.find_or_create_by(:name => ingredient_attribute[:name]) 
        if !self.ingredients.include?(ingredient) && ingredient.valid?
          self.recipe_ingredients.build(
            :ingredient => ingredient,
            :quantity => ingredient_attribute[:recipe_ingredients][:quantity], 
            :preparation => ingredient_attribute[:recipe_ingredients][:preparation]
          )     
        elsif recipe_ingredient = self.recipe_ingredients.find_by(:ingredient_id => ingredient.id, :recipe_id => self.id)
          recipe_ingredient.update(
          :quantity => ingredient_attribute[:recipe_ingredients][:quantity], 
          :preparation => ingredient_attribute[:recipe_ingredients][:preparation]
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

   def self.filter_options(params)
    if params[:ingredient_id].nil? && params[:category_id].nil?
      Recipe.all
    elsif params[:ingredient_id].present? && params[:category_id].present?
      Recipe.by_ingredient(params[:ingredient_id]).by_category(params[:category_id])
    elsif params[:category_id].present? && params[:ingredient_id].empty?
      Recipe.by_category(params[:category_id])
    elsif params[:ingredient_id].present? && params[:category_id].empty?
      Recipe.by_ingredient(params[:ingredient_id])
    end
  
  end

end
