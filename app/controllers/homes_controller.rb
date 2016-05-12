class HomesController < ApplicationController
  def index
    if params["commit"] == "Search"
      @homes = Home.where("description LIKE ?", "%#{params[:home][:address]}%").all
    else
      @homes = Home.all
    end
  end

  def search
    @home = Home.new
  end
end
