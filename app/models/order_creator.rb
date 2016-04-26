class OrderCreator

  def initialize(session)
    @session = session
    create_order
    create_order_tool
  end

  def create_order
    # current_user = User.find(@session[:user_id])
    cart = Cart.new(@session[:cart])
    @order = Order.new(user_id: @session[:user_id], total: cart.total, quantity: cart.quantity, status: "Ordered")
  end

  def create_order_tool
    @order_tools = @session[:cart].map do |tool_id, quantity|
      OrderTool.new(tool_id: tool_id, quantity: quantity)
    end
  end

  def save
    # byebug
    if @order.save
      @order_tools.each { |order_tool| order_tool.update_attributes(order_id: @order.id) }
    end
  end
end
