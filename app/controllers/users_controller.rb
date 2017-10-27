class UsersController < ApplicationController
  before_action :load_user, except: %i(index new create)
  before_action :logged_in_user, except: %i(show new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: %i(index destroy)

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

  def edit; end

  def update
    update_helper
    if @user.update_attributes @update_params
      flash[:success] = t "update_success"
      redirect_to @after_update_path
    else
      render :edit
    end
  end

  def index
    @users = User.alphabet_name.paginate(page: params[:page], per_page: Settings.paginate.user_perpage)
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".destroy_success"
    else
      flash[:danger] = t ".destroy_fail"
    end
    redirect_to users_url
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "cant_find_user"
    redirect_to root_url
  end

  def user_params
    params.require(:user).permit :name, :email, :address, :phone, :password, :password_confirmation, :picture
  end

  def admin_params
    params.require(:user).permit :name, :email, :address, :phone,
      :password, :password_confirmation, :picture, :admin
  end

  def correct_user
    load_user
    return if current_user? @user
    redirect_to root_url unless current_user.admin
  end

  def update_helper
    if current_user.admin?
      @update_params = admin_params
      @after_update_path = users_path
    else
      @update_params = user_params
      @after_update_path = @user
    end
  end
end
