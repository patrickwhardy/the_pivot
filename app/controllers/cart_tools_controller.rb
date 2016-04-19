class CartToolsController < ApplicationController
  def create
    # find the tool that got added to the cart
    @tool = Tool.find(params[:tool])
    # add it to the cart
    @cart.add_tool(@tool.id)
    session[:cart] = @cart.contents
    redirect_to tools_path
  end
end
