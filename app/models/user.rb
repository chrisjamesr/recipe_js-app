class User < ApplicationRecord
  has_many :recipes

  has_secure_password
  validates :name, presence: true, allow_blank: false
  validates :name, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: { in: 6..20 }

end
