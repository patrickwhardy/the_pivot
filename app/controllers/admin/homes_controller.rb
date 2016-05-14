class Admin::HomesController < ApplicationController
  
  def index
    if current_admin?
      @homes = Home.all
    else
      render file: "#{Rails.root}/public/404.html", status: 404
    end
  end

  def suspend
    home_to_suspend = Home.find(params[:id])
    home_to_suspend.suspend if current_admin?
    @homes = Home.all
    flash[:warning] = "#{home_to_suspend.name} has been suspended"
    redirect_to admin_homes_path
  end

  def reactivate
    home_to_reactivate = Home.find(params[:id])
    home_to_reactivate.reactivate if current_admin?
    @homes = Home.all
    flash[:success] = "#{home_to_reactivate.name} is reactivated"
    redirect_to admin_homes_path    
  end
end
