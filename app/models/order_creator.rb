class OrderCreator

  def initialize(session)
    #reservation, reserved_date, order_reservations, orders
    @session = session
    create_order
    create_order_tool
  end

  def create_reservations
    @session[:date].each do |tool_id, date_id|
      reservation = Reservation.create(tool_id: tool_id, date_reserved_id: date_id, user_id: @session[:user_id])
    end
  end

  def create_order
    cart = Cart.new(@session[:cart])
    @order = Order.new(user_id: @session[:user_id], total: cart.total, quantity: cart.quantity, status: "Ordered")
  end

  def create_order_tool
    @order_tools = @session[:cart].map do |tool_id, quantity|
      OrderTool.new(tool_id: tool_id, quantity: quantity)
    end
  end

  def save
    if @order.save
      @order_tools.each { |order_tool| order_tool.update_attributes(order_id: @order.id) }
      create_reservations
    end
  end
end
