class User < ApplicationRecord
  has_many :recipes

  has_secure_password
  validates :name, :allow_blank => false
  validates :password, :length => { in: 6..20 }

end
