class Home < ActiveRecord::Base
  validates :name,            presence: true
  validates :description,     presence: true
  validates :price_per_night, presence: true
  validates :address,         presence: true
  belongs_to :user
  has_many :reservations
  has_many :photos, :dependent => :destroy, inverse_of: :home
  accepts_nested_attributes_for :photos, :allow_destroy => true

  def upcoming_reservations
    self.reservations.where("checkout > ?", Date.today)
  end

  def past_reservations
    self.reservations.where("checkout < ?", Date.today)
  end

  def suspend
    self.suspended = true
    self.save
  end

  def suspended?
    self.suspended
  end
end
