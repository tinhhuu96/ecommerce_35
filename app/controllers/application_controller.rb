class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_cart

  include SessionsHelper
  include ProductsHelper
  include CategoriesHelper

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "please_login"
    redirect_to login_url
  end

  def admin_user
    return if current_user.admin?
    flash[:danger] = t "admin_require"
    redirect_to(root_url)
  end

  def load_all_category
    @categories = Category.all
  end

  def current_cart
    @cart = Order.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      if current_user.present?
        @cart = current_user.orders.new
      else
        @cart = Order.new
      end
  end
end
