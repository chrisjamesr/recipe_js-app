class IngredientSerializer < ActiveModel::Serializer
  attributes :id, :username
  has_many :recipe_ingredients
end
