class CategoriesController < ApplicationController
  before_action :load_products, only: %i(show)
  before_action :load_cates, only: %i(index show)

  def index; end

  def new; end

  def show; end

  private

  def load_cates
    @categories = Category.all
  end

  def load_products
    @products = Product.search_by_cate params[:id]
  end
end
