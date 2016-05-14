class Admin::HomesController < ApplicationController
  
  def index
    if current_admin?
      @homes = Home.all
    else
      render file: "#{Rails.root}/public/404.html", status: 404
    end
  end
end
