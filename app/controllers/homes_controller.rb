class HomesController < ApplicationController
  def index
    if request.referrer == "http://www.example.com/search"
      @homes = Home.where("description LIKE ?", "%#{params[:home][:description]}%").all
    else
      @homes = Home.all
    end
  end

  def search
    @home = Home.new
  end
end
