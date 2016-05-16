class User < ActiveRecord::Base
  has_secure_password
  has_many :homes
  has_many :orders
  has_many :reservations, through: :orders
  has_many :user_roles
  has_many :roles, through: :user_roles
  validates :email,      presence: true, uniqueness: true
  validates :username,   presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name,  presence: true
  has_attached_file :avatar,
  default_url: "https://s3.amazonaws.com/tinystays/avatar-missing.jpeg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  enum status: %w(active deleted)

  def admin?
    roles.exists?(role: "admin")
  end

  def retire
    self.deleted!
    homes.each { |home| home.suspended! }
  end

  def retire
    self.deleted!
    homes.each { |home| home.suspended! }
  end

  def upcoming_reservations
    self.reservations.where("checkout > ?", Date.today)
  end

  def past_reservations
    self.reservations.where("checkout < ?", Date.today)
  end

  def home_owner?
    !homes.empty?
  end

  def self.home_owners
    User.where("EXISTS(SELECT 1 from homes where users.id = homes.user_id)")
  end
end
