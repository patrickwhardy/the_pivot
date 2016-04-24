class User < ActiveRecord::Base
  has_secure_password
  validates :username, presence: true

  enum role: %w(user admin)
end
