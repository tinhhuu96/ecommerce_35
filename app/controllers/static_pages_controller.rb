class StaticPagesController < ApplicationController
  before_action :logged_in_user, only: %i(products_manager categories_manager)
  before_action :admin_user, only: %i(products_manager categories_manager)

  def home
    @hot_products = Product.hot_trend
    @products = Product.get_lastest_product Settings.product.lastest_product
    @categories = Category.all
  end

  def help; end

  def about; end

  def contact; end

  def categories_manager
    @count = 0
    @categories = Category.all
    @super_categories = Category.get_sub_category 0
  end

  def products_manager
    @products = Product.sort_by_name.paginate(page: params[:page], per_page: Settings.paginate.user_perpage)
  end
end
