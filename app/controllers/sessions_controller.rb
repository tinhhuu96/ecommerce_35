class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      create_param user
      redirect_back_or user
    else
      flash.now[:danger] = t "login_error_msg"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def create_param user
    params[:session][:remember_me] == Settings.checkbox.true ? remember(user) : forget(user)
  end
end
