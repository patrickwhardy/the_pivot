class Admin::OwnersController < ApplicationController

  def index
    if current_admin?
      @owners = User.joins(:homes).uniq
    else
      render file: "#{Rails.root}/public/404.html", status: 404
    end
  end

end
