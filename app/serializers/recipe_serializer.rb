class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :title, :time, :user_id, :description, :directions, :created_at
end
