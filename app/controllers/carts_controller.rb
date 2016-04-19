class CartsController < ApplicationController
  def show
    @toolbag = toolbag.first
    @cart_total = cart_total
  end

  def toolbag
    @toolbag = session[:cart].map do |tool_id, amount|
      {Tool.find(tool_id) => amount}
    end
  end

  def cart_total
    @toolbag.map do |tool, quantity|
      tool.price * quantity
    end.reduce(:+)
  end
end
