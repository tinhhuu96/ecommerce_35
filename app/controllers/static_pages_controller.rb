class StaticPagesController < ApplicationController
  before_action :logged_in_user, only: %i(products_manager)
  before_action :admin_user, only: %i(products_manager)

  def home
    @products = Product.hot_trend
    @categories = Category.all
  end

  def help; end

  def about; end

  def contact; end

  def products_manager
    @products = Product.sort_by_name.paginate(page: params[:page], per_page: Settings.paginate.user_perpage)
  end
end
