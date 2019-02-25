
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

10.times do 
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Number.number(8)
  )
end

4.times do
  User.all.each do |user|
    user.recipes.create(
      :title => Faker::Food.dish,
      :description => Faker::Food.description,
      :time => Faker::Number.between(1, 90),
      :directions => Faker::Lorem.paragraph(1)
      )   
  end
end

10.times do
  Ingredient.create(
    :name => Faker::Food.ingredient
    )
  Ingredient.create(
    :name => Faker::Food.spice
    )
  Ingredient.create(
    :name => Faker::Food.vegetables
    )
end
60.times do 
  RecipeIngredient.create(
    :recipe_id => Recipe.all.sample.id,
    :ingredient_id => Ingredient.all.sample.id,
    :quantity => Faker::Food.measurement,
    :preparation => PREP_DIRECTIONS.sample
    )
end

4.times do
  Recipe.all.each do |recipe|
    recipe.recipe_categories.create(
      :category_id => Category.all.sample.id
      )
  end
end

