class CartToolsController < ApplicationController
  def create
    year = params[:reserve_date]["date(1i)"]
    month = params[:reserve_date]["date(2i)"]
    day = params[:reserve_date]["date(3i)"]
    date = DateReserved.find_or_create_by(date_reserved: "#{year}-#{month}-#{day}")
    @tool = Tool.find(params[:id])

    if date.date_reserved < DateTime.yesterday
      flash[:error] = "Tools cannot be rented on past dates."
      redirect_to tool_path(@tool)
    elsif !Reservation.where({tool_id: @tool.id, date_reserved_id: date.id }).empty?
      flash[:error] = "Tool Unavailable"
      redirect_to tool_path(@tool)
    else
      @cart.add_tool(@tool.id)
      session[:cart] = @cart.contents
      session[:date] = {"#{@tool.id}" => date.id}
      flash[:success] = "Tool added to cart."
      redirect_to tools_path
    end
  end

  def destroy
    @cart.remove(params[:id])
    flash[:alert] = "Tool removed from cart."
    redirect_to cart_path
  end
end
