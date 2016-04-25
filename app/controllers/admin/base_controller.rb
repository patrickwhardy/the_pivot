class Admin::BaseController < ApplicationController
  before_action :check_for_admin

  def check_for_admin
    # byebug
    unless current_admin?
      render file: "#{Rails.root}/public/404.html", status: 404
    end
  end
end
