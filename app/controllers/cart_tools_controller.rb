class CartToolsController < ApplicationController
  def create
    @tool = Tool.find(params[:id])
    @cart.add_tool(@tool.id)
    session[:cart] = @cart.contents

    flash[:success] = "Tool added to cart."
    redirect_to tools_path
  end

  def destroy
    @cart.remove(params[:id])
    flash[:alert] = "Tool removed from cart."
    redirect_to cart_path
  end
end
