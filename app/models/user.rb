class User < ActiveRecord::Base
  has_secure_password
  has_many :homes
  validates :email,      presence: true, uniqueness: true
  validates :username,   presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name,  presence: true
  enum role: %w(user admin)
end
