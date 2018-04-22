class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :title, :time, :user_id, :description, :directions, :created_at
  belongs_to :user, serializer: UserSerializer
end
