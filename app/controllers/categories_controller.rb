class CategoriesController < ApplicationController
  before_action :load_products, only: %i(show)
  before_action :load_cates, except: %i(destroy update)
  before_action :load_cate, except: %i(index create new)
  before_action :avoid_destroy_when_have_sub_category, only: :destroy

  def index; end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t ".add_success"
      redirect_to categories_manager_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @category.update_attributes(category_params)
      flash[:success] = t "updated"
      redirect_to categories_manager_path
    else
      render :edit
    end
  end

  def show; end

  def destroy
    if @category.destroy
      flash[:success] = t ".destroy_success"
    else
      flash[:danger] = t ".destroy_fail"
    end
    redirect_to categories_manager_path
  end

  private

  def avoid_destroy_when_have_sub_category
    return unless has_sub_cate? @category
    flash[:danger] = t ".destroy_fail_because_of_sub"
    redirect_to categories_manager_path
  end

  def load_cate
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:danger] = t "cant_find_category"
    redirect_to categories_manager_path
  end

  def load_cates
    @categories = Category.all
  end

  def load_products
    @products = Product.search_by_cate params[:id]
  end

  def category_params
    params.require(:category).permit :name, :parent_id
  end
end
