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

  def reserved_dates
    reservation_nights.map do |date|
      date.night.to_s
    end.uniq
  end

  def upcoming_reservations
    self.reservations.where("checkout > ?", Date.today)
  end

  def past_reservations
    self.reservations.where("checkout < ?", Date.today)
  end

  def self.markers(homes)
    Gmaps4rails.build_markers(homes) do |home, marker|
      marker.lat home.latitude
      marker.lng home.longitude
      marker.infowindow home.linked_name
    end
  end

  def linked_name
    '<a href="/' + self.user.slug + '/homes/' + self.id.to_s + '">' + self.name + '</a>'
  end

  enum status: %w(active suspended)
end
