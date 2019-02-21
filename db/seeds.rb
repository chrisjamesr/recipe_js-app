
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
FOOD_CATEGORIES = ['Appetizers', 'Desserts', 'Holiday Foods', 'Meat', 'Entres', 'Vegeterian', 'Vegan', 'Breakfast']
PREP_DIRECTIONS =['Chopped', 'Diced', 'Grated', 'Sliced']
FOOD_MEASUREMENTS = ['1 tsp', ' 1 tbsp', '1 oz', '1 cup']
qty = -> measure {"#{(rand*10).floor} #{measure}"}

FOOD_CATEGORIES.each do |category|
    Category.create(name: category)
end

10.times do 
  User.create(
    name: FFaker::Name.name,
    email: FFaker::Internet.safe_email,
    password: FFaker::Internet.password
  )
end

4.times do
  User.all.each do |user|
    user.recipes.create(
      :title => FFaker::Food.dish,
      :description => FFaker::Food.description,
      :time => FFaker::Number.between(1, 90),
      :directions => FFaker::TheFreshPrinceOfBelAir.quote 
      )   
  end
end

10.times do
  Ingredient.create(
    :name => Ffaker::Food.ingredient
    )
  Ingredient.create(
    :name => FFaker::Food.herb_or_spice
    )
end
60.times do 
  RecipeIngredient.create(
    :recipe_id => Recipe.all.sample.id,
    :ingredient_id => Ingredient.all.sample.id,
    :quantity => qty.call(FOOD_MEASUREMENTS.sample)
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

