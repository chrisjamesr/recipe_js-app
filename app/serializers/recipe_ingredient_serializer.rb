class RecipeIngredientSerializer < ActiveModel::Serializer
  attributes :id, :recipe_id, :ingredient_id, :quantity, :preparation
  belongs_to :recipe
end

