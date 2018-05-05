class CommentSerializer < ActiveModel::Serializer
  attributes :id, :text, :recipe_id, :user_id, :user_name
  # belongs_to :user
  # belongs_to :recipe

  def user_name
    object.user.name
  end


end
