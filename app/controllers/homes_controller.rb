class HomesController < ApplicationController
  def index
    if params[:location].present? && params[:checkin].present? && params[:checkout].present?
      @homes = Home.near(params[:location], 50).all.to_a.select { |home| home.reservations.dates_reserved(home.id, params[:checkin], params[:checkout]).empty? }
    elsif params[:location].present?
      @homes = Home.near(params[:location], 50)
    else
      @homes = Home.all
    end
  end

  def search
    @home = Home.new
  end
end
