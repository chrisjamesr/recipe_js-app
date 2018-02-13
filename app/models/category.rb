class Category < ApplicationRecord
  

  has_many :recipe_categories
  has_many :recipes, :through => :recipe_categories

  validates :name, :presence => true, :allow_blank => false, :uniqueness => {:case_sensitive => false}

end
