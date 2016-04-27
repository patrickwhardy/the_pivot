class Admin::UsersController < Admin::BaseController
  def show
    @user = current_user
  end
end
