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
  scope :by_user, ->(user_id){where(:user_id => user_id)}
  scope :newest, ->{order(:created_at => :desc)}
  scope :oldest, ->{order(:created_at => :asc)}
  scope :shortest, ->{order(:time => :asc)}
  scope :longest, ->{order(:time => :desc)}
  # scope :next, ->(user_id, current_id){where("user_id = ?",user_id).where("id > ?",current_id).first}
  # scope :previous, ->(user_id, current_id){where("user_id = ?",user_id).where("id < ?",current_id).first}

  def ingredients_attributes=(ingredients_attributes)
    ingredients_attributes.each do |i, ingredient_attribute|
      if ingredient_attribute.present?
        ingredient = Ingredient.find_or_create_by(:name => ingredient_attribute[:name]) 
        if !self.ingredients.include?(ingredient) && ingredient.valid?
          self.recipe_ingredients.new(
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
      if category_attribute.present? & !category_attribute[:name].empty?
        category = Category.find_or_create_by(category_attribute)
        if !self.categories.include?(category)
          self.recipe_categories.build(:category => category)
        end
      end
    end
  end
 
  def self.filter_options(filter_params)
    filter_keys = filter_params.select{ |k, v| v.present?}   
    if filter_keys.present?
      filter_keys.inject(self){|k, v| k.send(*v)}
    else
      Recipe.all
    end
  end  

  def self.find_recipe(user_id, new_recipe_id, current_recipe_id)
    if !!new_recipe_id
      if new_recipe_id.to_i > current_recipe_id.to_i
        # next
        if recipe = Recipe.where("user_id = ?",user_id).where("id > ?",current_recipe_id).first
          recipe
        else 
          recipe = Recipe.where("user_id = ?", user_id).first
        end
      elsif new_recipe_id.to_i < current_recipe_id.to_i
        # previous
        # binding.pry
        if recipe = Recipe.where("user_id = ?",user_id).where("id < ?",current_id).first
          recipe
        else
          recipe = Recipe.where("user_id = ?", user_id).last
        end
      end
    else
      Recipe.find(current_recipe_id)
    end
  end

  
end #end of Class
