Recipe App.md

Usage
  Root
    Sign Up
    Log In w/pw
    Log In w/Facebook
    Log Out

  User Show Page
    Display User into
     display user/recipes
  User Index Page?
  
  Recipe Index Page
    Display all most recent
    filter recipes by User
    filter recipes by Ingredients
    filter recipes by Category
    filter recipes by time  

  Recipe Show Page
    Recipe Title - Recipe Time
    Recipe Description
    Recipe Instructions (recipe_ingredient quantity, direction) 
    
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



 <%#= f.fields_for :recipe_ingredients, @recipe.recipe_ingredients.build do |ingredient_fields| %>
    <%#= ingredient_fields.collection_select(:ingredient, Ingredient.all, :id, :name, {prompt: 'Select Ingredient'}) %>
    <%#= ingredient_fields.hidden_field :recipe_id, :value => @recipe.id %>
    <%#= ingredient_fields.label "Quantity:  "%>
    <%#= ingredient_fields.text_field :quantity %>
    <%#= ingredient_fields.label "Directions: "%>
    <%#= ingredient_fields.text_area :direction %>

      <%#= ingredient_fields.collection_select(:ingredient, Ingredient.all, :id, :name, {prompt: 'Select Ingredient'}) %>
    <%#= ingredient_fields.label "Quantity:  "%>
    <%#= ingredient_fields.text_field :quantity %>
    <%#= ingredient_fields.label "Directions: "%>
    <%#= ingredient_fields.text_area :direction %>
       <%#= ingredient_fields.collection_select(:ingredient, Ingredient.all, :id, :name, {prompt: 'Select Ingredient'}) %>
    <%#= ingredient_fields.label "Quantity:  "%>
    <%#= ingredient_fields.text_field :quantity %>
    <%#= ingredient_fields.label "Directions: "%>
    <%#= ingredient_fields.text_area :direction %>
  <%# end %>

  <%#= f.collection_check_boxes(:ingredient_attributes, Ingredient.all, :id, :name) do |i| %>
    <%#= i.label(:"data-value" => i.value) { i.check_box + i.text } %>
      <%#= fields_for i.object.recipe_ingredients.build do |r_i| %>
        <%#= r_i.hidden_field :recipe_id, :value => "#{@recipe.id}" %>
        <%#= r_i.hidden_field :ingredient_id %>
        <%#= r_i.label :quantity%>
        <%#= r_i.text_area :quantity %>
      <%# end%>    
  <%# end %>

  <%# New Ingredient Text Field %>
  

 

  
  