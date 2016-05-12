class Cart
  attr_reader :contents, :notice

  def initialize(session_contents)
    @contents = session_contents || []
  end

  def add_home(home_id, checkin, checkout)
    checkin_date = Date.parse("#{checkin["date(1i)"]}/#{checkin["date(2i)"]}/#{checkin["date(3i)"]}")
    checkout_date = Date.parse("#{checkout["date(1i)"]}/#{checkout["date(2i)"]}/#{checkout["date(3i)"]}")
    reserved_dates = get_reserved_dates(home_id, checkin_date, checkout_date) unless Reservation.find_by(home_id: home_id).nil?
    if reserved_dates == [] || reserved_dates.nil?
      total_days = (checkout_date - checkin_date).to_i
      @contents << { home: home_id, checkin: checkin_date, checkout: checkout_date, total_days: total_days }
      []
    else
      reserved_dates
    end
  end

  def get_reserved_dates(home_id, checkin, checkout)
      (checkin..checkout).map do |date|
        Reservation.find_by(home_id: home_id).reservation_nights.find_by(night: date)
      end.compact.map do |reservation_night|
        reservation_night.night.to_s
      end
  end

  def get_homes
    @cart_homes ||= @contents.each { |reservation| reservation["home"] = Home.find(reservation["home"]) }
  end

  def total
    @contents.reduce(0) do |sum, reservation|
      sum + Home.find(reservation["home"]).price_per_night * reservation["total_days"]
    end
  end

  def clear_contents
    @contents = {}
  end

  def quantity
    @contents.size
  end

  def remove(tool_id)
    @contents.delete(tool_id)
  end

  def update_quantity(new_data)
    if new_data[:quantity].to_i == 0
      @contents.delete(new_data[:tool_id])
    else
      @contents[new_data[:tool_id]] = new_data[:quantity].to_i
    end
  end
end
