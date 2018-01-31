Recipe App.md

Models

User
  Associations
    has_many :recipes

  Attributes
    Name
    Password
    Email
  Actions
    New    
    Create
    Show
    Edit
    Update

Recipe
  Associations
    belongs_to :user

    has_many: recipe_ingredients
    has_many :ingredients, :through => :recipe_ingredients
    *** NOT IN USE ***
    has_many :recipe_categories
    has_many :categories, :through => :recipe_categories
    ******************
  Attributes
    Title
    User_id
    Time
    Description
    -directions?
  Actions 
    New 
    Create
    Show
    Edit
    Update
    Destroy

Ingredient
  Associations
    belongs_to :recipe
    has_many :recipes_ingredients
    has_many :recipes, :through => :recipe_ingredients

  Attributes
    Name
  Actions
    New 
    Create
    Show
    Edit
    Update
    Destroy

Category
  Associations
  has_many :recipes
  *** NOT IN USE ***
    has_many :recipe_categories
    has_many :recipes, :through => recipe_categories
  ******************
  Attributes
    Name
  Actions
    Create
    Show
    Index
    Destroy?  

Recipe_Ingredient
  Associations
    belongs_to :recipe
    belongs_to :ingredient
  Attributes  
    Recipe_id
    Ingredient_id
    Directions
    Quanity

*** NOT IN USE ***
Recipe_Category
  Associations
    belongs_to :recipe
    belongs_to :category
  Attributes
    Recipe_id
    Category_id   
******************



