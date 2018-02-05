
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
FOOD_CATEGORIES = ['Appetizers', 'Desserts', 'Holiday Foods', 'Meat', 'Entres', 'Vegeterian', 'Vegan', 'Breakfast']
PREP_DIRECTIONS =['Chopped', 'Diced', 'Grated', 'Sliced']
FOOD_CATEGORIES.each do |category|
    Category.create(name: category)
end

5.times do 
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Number.number(8)
  )
end

2.times do
  User.all.each do |user|
    user.recipes.create(
      :title => Faker::Food.dish,
      :description => Faker::Food.description,
      :time => Faker::Number.between(1, 90) 
      )   
  end
end

15.times do
  Ingredient.create(
    :name => Faker::Food.ingredient
    )
end

20.times do 
  RecipeIngredient.create(
    :recipe_id => Recipe.all.sample.id,
    :ingredient_id => Ingredient.all.sample.id,
    :quantity => Faker::Food.measurement,
    :direction => PREP_DIRECTIONS.sample
    )
end

2.times do
  Recipe.all.each do |recipe|
    recipe.recipe_categories.create(
      :category_id => Category.all.sample.id
      )
  end
end

# counter = 1
# Item.all.each do |item|
#   item.category_id = counter
#   item.save
#   counter += 1
# end

# # User.create(name: 'Alex', email:'alex@home.com')
# 10.times do 
#   User.create(
#   :name => Faker::Name.name,    
#   :password => Devise.friendly_token.first(8),
#   :email => Faker::Internet.email 
#   ) 
# end

# User.all do |user|
#   Cart.create(:user => user) do |cart|
#     cart.line_items.build(:item => Item.first, :quantity =>1)
#   end
# end