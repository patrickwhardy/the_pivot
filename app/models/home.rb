class Home < ActiveRecord::Base
  validates :name,            presence: true
  validates :description,     presence: true
  validates :price_per_night, presence: true
  validates :address,         presence: true
  belongs_to :user
  has_many :photos
  accepts_nested_attributes_for :photos
end
