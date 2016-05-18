class HomesController < ApplicationController
  def index
    if params["commit"] == "Search"
      @homes = Home.where("address LIKE ?", "%#{params[:home][:address]}%").all
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
