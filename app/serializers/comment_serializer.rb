class CommentSerializer < ActiveModel::Serializer
  attributes :id, :text, :recipe_id, :user_id
  # belongs_to :user
  # belongs_to :recipe

  # def recipe_id
  #   object.recipe.id
  # end

  # def user_id
  #   object.user.id
  # end
end
