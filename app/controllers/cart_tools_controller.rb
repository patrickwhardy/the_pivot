class CartToolsController < ApplicationController
  def create
    year = params[:reserve_date]["date(1i)"]
    month = params[:reserve_date]["date(2i)"]
    day = params[:reserve_date]["date(3i)"]
    date = DateReserved.find_or_create_by(date_reserved: "#{year}-#{month}-#{day}")
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
