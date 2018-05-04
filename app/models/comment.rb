class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  validates :text, :user_id, :recipe_id, presence: true, allow_blank: false
end
