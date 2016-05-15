class Cart
  attr_reader :contents, :notice

  def initialize(session_contents)
    @contents = session_contents || []
  end

  def add_home(home_id, checkin, checkout)
    checkin_date = Date.parse("#{checkin["date(1i)"]}/#{checkin["date(2i)"]}/#{checkin["date(3i)"]}")
    checkout_date = Date.parse("#{checkout["date(1i)"]}/#{checkout["date(2i)"]}/#{checkout["date(3i)"]}")
    total_days = (checkout_date - checkin_date).to_i
    @contents << { home: home_id, checkin: checkin_date, checkout: checkout_date, total_days: total_days }
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
end
