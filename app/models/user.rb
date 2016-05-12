class User < ActiveRecord::Base
  has_secure_password
  has_many :homes
  has_many :orders
  has_many :reservations, through: :orders
  validates :email,      presence: true, uniqueness: true
  validates :username,   presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name,  presence: true
  has_attached_file :avatar,
  default_url: "https://s3.amazonaws.com/tinystays/avatar-missing.jpeg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  enum role: %w(user admin)
end
