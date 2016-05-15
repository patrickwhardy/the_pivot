class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find_by(slug: params[:user])
    redirect_to root_path unless current_user == @user || current_admin?
  end

  def create
    @user = User.new(user_params)
    @user.slug = @user.username.parameterize
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Account created. Welcome to TinyStay, #{@user.username}"
      if session[:cart]
        redirect_to cart_path
      else
        redirect_to dashboard_path(@user.slug)
      end
    else
      flash[:error] = @user.errors.full_messages.join(", ")
      redirect_to request.referrer
    end
  end

  def edit
    @user = User.find_by(slug: params[:slug])
    redirect_to root_path unless current_user == @user || current_admin?
  end

  def update
    @user = User.find_by(slug: params[:slug])
    if @user == current_user || current_admin?
      @user.update(user_params)
      @user.slug = @user.username.parameterize
      if @user.save
        flash[:notice] = "Account successfully updated"
        redirect_to dashboard_path(@user.slug)
      else
        flash[:error] = @user.errors.full_messages.join(", ")
        render :edit
      end
    end
  end

  def destroy
    @user = User.find_by(slug: params[:slug])
    if @user == current_user || current_admin?
      session.clear if @user == current_user
      @user.retire
      @user.save
      flash[:notice] = "Account successfully deleted"
      redirect_to request.referrer
    else
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :username,
      :password,
      :email,
      :first_name,
      :last_name,
      :description
    )
  end
end
