class Home < ActiveRecord::Base
  validates :name,            presence: true
  validates :description,     presence: true
  validates :price_per_night, presence: true
  validates :address,         presence: true
  belongs_to :user
  has_many :reservations
  has_many :reservation_nights, through: :reservations
  has_many :photos, :dependent => :destroy, inverse_of: :home
  accepts_nested_attributes_for :photos, :allow_destroy => true

  geocoded_by :address
  after_validation :geocode       
  
  def upcoming_reservations
    self.reservations.where("checkout > ?", Date.today)
  end

  def past_reservations
    self.reservations.where("checkout < ?", Date.today)
  end

  enum status: %w(active suspended)
end
