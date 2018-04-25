class RecipeIngredientSerializer < ActiveModel::Serializer
  attributes :id, :recipe_id, :ingredient_id, :quantity, :preparation
  belongs_to :recipe
  belongs_to :ingredient, serializer: IngredientSerializer
end

