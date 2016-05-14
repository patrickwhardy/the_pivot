class Admin::OwnersController < Admin::BaseController

  def index
    @users = User.home_owners
  end
end
