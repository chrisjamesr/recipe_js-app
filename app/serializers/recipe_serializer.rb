class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :title, :time, :user_id, :description, :directions, :created_at
  belongs_to :user, serializer: UserSerializer
  has_many :recipe_ingredients, serializer: RecipeIngredientSerializer
  has_many :ingredients, through: :recipe_ingredients
end
