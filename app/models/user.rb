class User < ActiveRecord::Base
  has_secure_password
  has_many :orders
  validates :username, presence: true

  enum role: %w(user admin)

  def has_orders?
    orders.count > 0
  end
end
