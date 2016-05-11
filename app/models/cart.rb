class Cart
  attr_reader :contents, :notice

  def initialize(session_contents)
    @contents = session_contents || []
  end

  def add_home(home_id, checkin, checkout)
    checkin_date = Date.parse("#{checkin["date(1i)"]}/#{checkin["date(2i)"]}/#{checkin["date(3i)"]}")
    checkout_date = Date.parse("#{checkout["date(1i)"]}/#{checkout["date(2i)"]}/#{checkout["date(3i)"]}")
    total_days = (checkout_date - checkin_date).to_i
    # checkin_year = checkin["date(1i)"]
    # checkin_month = checkin["date(2i)"]
    # checkin_day = checkin["date(3i)"]

    # checkout_year = checkout["date(1i)"]
    # checkout_month = checkout["date(2i)"]
    # checkout_day = checkout["date(3i)"]
    @contents << { home: home_id, checkin: checkin_date, checkout: checkout_date, total_days: total_days }
  end

  def get_homes
    # byebug
    @cart_homes ||= @contents.each { |reservation| reservation["home"] = Home.find(reservation["home"]) }
  end

  def total
    #for each item in cart homes
    #subtract checkin from checkout_day
    #multiply remainder by price per night
    @contents.reduce(0) do |sum, reservation|
    #  byebug
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

  def subtotal(tool_id)
    0
    # tool = Tool.find(tool_id)
    # tool.price * @toolbag[tool]
  end
end
