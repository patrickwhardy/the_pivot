class HomesController < ApplicationController
  def index
    if params["commit"] == "Search"
      @homes = Home.where("address LIKE ?", "%#{params[:home][:address]}%").all
      @hash = Gmaps4rails.build_markers(@homes) do |home, marker|
        marker.lat home.latitude
        marker.lng home.longitude
        marker.infowindow home.name
      end
    else
      @homes = Home.all
      @hash = Gmaps4rails.build_markers(@homes) do |home, marker|
        marker.lat home.latitude
        marker.lng home.longitude
        marker.infowindow home.name
      end
    end
  end

  def search
    @home = Home.new
  end
end
