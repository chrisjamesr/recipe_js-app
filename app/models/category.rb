class Category < ApplicationRecord
  has_many :recipes

  validates :name, presence: true, allow_blank: false
end
