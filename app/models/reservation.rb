class Reservation < ActiveRecord::Base
  has_many :reservation_nights
  belongs_to :home

  def self.dates_reserved(home_id, checkin, checkout)
    checkin_date = Date.parse("#{checkin["date(1i)"]}/#{checkin["date(2i)"]}/#{checkin["date(3i)"]}")
    checkout_date = Date.parse("#{checkout["date(1i)"]}/#{checkout["date(2i)"]}/#{checkout["date(3i)"]}")
    if self.find_by(home_id: home_id).nil?
     []
    else
      reserved_dates = get_reserved_dates(home_id, checkin_date, checkout_date)
    end
  end

  def self.get_reserved_dates(home_id, checkin, checkout)
    (checkin..checkout).map do |date|
      self.where(home_id: home_id).joins(:reservation_nights).where(reservation_nights: { night: date }).pluck(:night)
    end.flatten
  end

end
