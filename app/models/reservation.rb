class Reservation < ActiveRecord::Base
  has_many :reservation_nights
  belongs_to :home

  def self.dates_reserved(home_id, checkin, checkout)
    checkin = parse_dates_hash(checkin)
    checkout = parse_dates_hash(checkout)
    return Array.new if self.find_by(home_id: home_id).nil?
    reserved_dates = get_reserved_dates(home_id, checkin, checkout)
  end

  def self.get_reserved_dates(home_id, checkin, checkout)
    (checkin..checkout).map do |date|
      self.where(home_id: home_id).joins(:reservation_nights).where(
        reservation_nights: { night: date }
      ).pluck(:night)
    end.flatten
  end

  private

  def self.parse_dates_hash(date)
    Date.parse(
      "#{date["date(1i)"]}/#{date["date(2i)"]}/#{date["date(3i)"]}"
    )
  end
end
