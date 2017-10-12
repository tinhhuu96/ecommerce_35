class ProductsController < ApplicationController
  before_action :load_category, only: %i(index)

  def new; end

  def index
    @products = if @category
      @category.products
    elsif params[:get].present?
      select_price
      if @price
        Product.search_by_price(@start,@last)
      else
        Product.sort_by_name
      end
    else
      Product.all
    end.search_by_name params[:search]
  end

  def load_category
    unless params[:category].nil?
      @category = Category.find_by name: params[:category]
      return if @category
      render file: "public/404.html"
    end
  end

  def select_price
    setting_product = Settings.controllers.products
    return if params.require(:get).permit(:price) == setting_product.all
    @price = params.require(:get).permit(:price)
    @price = @price[:price].split(setting_product.to)
    @start = @price[setting_product.start]
    @last = @price[setting_product.last]
  end
end
