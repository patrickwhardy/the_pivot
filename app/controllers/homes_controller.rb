class HomesController < ApplicationController
  def index
    session[:checkin] = params[:checkin]
    session[:checkout] = params[:checkout]
    if params[:location].present? && params[:checkin].present? && params[:checkout].present?
      @homes = Home.near(params[:location], 50).all.to_a.select { |home| home.reservations.dates_reserved(home.id, params[:checkin], params[:checkout]).empty? }
      @hash = Home.markers(@homes)
    elsif params[:checkin].present? && params[:checkout].present?
      @homes = Home.all.to_a.select { |home| home.reservations.dates_reserved(home.id, params[:checkin], params[:checkout]).empty? }
      @hash = Home.markers(@homes)
    elsif params[:location].present?
      @homes = Home.near(params[:location], 50)
      @hash = Home.markers(@homes)
    else
      @homes = Home.all
      @hash = Home.markers(@homes)
    end
  end

  def search
    @home = Home.new
  end
end
