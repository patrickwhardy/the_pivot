class Admin::HomesController < Admin::BaseController

  def index
    @homes = Home.all
  end

  def suspend
    home = Home.find(params[:id])
    home.suspended!
    flash[:warning] = "#{home.name} has been suspended"
    redirect_to admin_homes_path
  end

  def reactivate
    home = Home.find(params[:id])
    home.active!
    flash[:success] = "#{home.name} is reactivated"
    redirect_to admin_homes_path
  end
end
