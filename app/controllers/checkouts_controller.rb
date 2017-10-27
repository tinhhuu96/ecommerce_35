class CheckoutsController < ApplicationController
  before_action :update_quantity_product, only: [:create]
  def index
    @user = current_user
    return if @user
    flash[:danger] = t "please_login"
    redirect_to root_path
  end

  def create
    if update_cart order_params
      UserNotifierMailer.send_order_email(current_user, @cart).deliver_now
      flash[:success] = t "order_success_pls_check_mail"
      session[:cart_id] = nil
    else
      flash[:danger] = t "order_error"
    end
    redirect_to root_path
  end

  def load_product product_id
    @product = Product.find_by id: product_id
    return if @product
    flash[:danger] = t "not_found_product"
    redirect_to cart_path
  end

  private

  def order_params
    params.require(:user).permit :name, :phone, :email, :address
  end

  def update_cart params_order
    if @cart.update_attributes params_order
      @cart.placed!
    else
      flash[:danger] = t "order_error"
    end
  end

  def update_quantity_product
    @cart.order_details.each do |item|
      load_product item.product_id
      quantity = @product.quantity - item.quantity
      unless @product.update_attributes(quantity: quantity)
        flash[:danger] = "quantity not avalible"
        redirect_to cart_path
      end
    end
  end
end
