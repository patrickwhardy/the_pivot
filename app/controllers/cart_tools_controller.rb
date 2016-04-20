class CartToolsController < ApplicationController
  def create
    @tool = Tool.find(params[:tool])
    @cart.add_tool(@tool.id)
    session[:cart] = @cart.contents
    redirect_to tools_path
  end

  def destroy
    @cart.remove(params[:id])
    redirect_to cart_path
  end

  def update
    # change quantities
    @cart.update_quantity(params[:cart_tool])
    # redirect to page where we show the quantity with new quantities
    redirect_to cart_path
  end
end
