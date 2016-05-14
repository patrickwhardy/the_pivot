class Admin::HomesController < ApplicationController
  
  def index
    if current_admin?
      @homes = Home.all
    else
      render file: "#{Rails.root}/public/404.html", status: 404
    end
  end

  def suspend
    Home.find(params[:id]).suspend if current_admin?
    @homes = Home.all
    redirect_to admin_homes_path
  end
end
