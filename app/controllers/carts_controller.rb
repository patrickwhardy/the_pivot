class CartsController < ApplicationController
  def show
    @toolbag = toolbag
    @cart_total = cart_total(@toolbag)
  end

  def toolbag
    session[:cart].transform_keys { |key| Tool.find(key) }
  end

  def cart_total(toolbag)
    toolbag.map do |tool, quantity|
      tool.price * quantity
    end.reduce(:+)
  end
end
