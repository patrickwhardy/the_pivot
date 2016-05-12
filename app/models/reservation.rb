class Reservation < ActiveRecord::Base
  has_many :reservation_nights
  belongs_to :home
end
