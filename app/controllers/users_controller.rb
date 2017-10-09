class UsersController < ApplicationController
  before_action :load_user, only: :show

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t ".sign_up_success"
      log_in @user
      redirect_to @user
    else
      render :new
    end
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "cant_find_user"
    redirect_to root_url
  end

  def user_params
    params.require(:user).permit :name, :email, :address, :phone, :password, :password_confirmation
  end
end
