class CartHomesController < ApplicationController
  def create


    # @home = Home.find(params[:id])

    #the following lines validate incoming dates
    # if date.date_reserved < DateTime.yesterday
    #   flash[:error] = "Tools cannot be rented on past dates."
    #   redirect_to tool_path(@tool)
    # elsif !Reservation.where({tool_id: @tool.id, date_reserved_id: date.id }).empty?
    #   flash[:error] = "Tool Unavailable"
    #   redirect_to tool_path(@tool)
    # else
      @cart.add_home(params[:id], params[:checkin_date], params[:checkout_date] )
      session[:cart] = @cart.contents
      # session[:date] = {"#{@tool.id}" => date.id}
      flash[:success] = "You've added this reservation to your cart"
      redirect_to request.referrer
    # end
  end

  def destroy
    @cart.remove(params[:id])
    flash[:alert] = "Tool removed from cart."
    redirect_to cart_path
  end
end
