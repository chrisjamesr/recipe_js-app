class User < ApplicationRecord
  has_many :recipes
  has_many :comments

  has_secure_password
  validates :name, presence: true, allow_blank: false
  validates :name, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: { in: 6..20 }

  def self.login_from_omniauth(auth)
    find_from_omniauth(auth) || create_from_omniauth(auth)
  end

  def self.find_from_omniauth(auth)
    find_by(:email => auth[:info][:email])
  end

  def self.create_from_omniauth(auth)
    create(:email => auth[:info][:email],
      :name => auth[:info][:name],
      :password => Password.pronounceable(10)) 
  end

end
