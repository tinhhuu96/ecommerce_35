class OrderDetailsController < ApplicationController
  before_action :load_item, only: %i(update destroy)

  def create
    if current_user.present?
      @order_item = @cart.add_product(order_item_params)
      unless @cart.save
        flash[:danger] = t "can_not_add_cart"
        redirect_to root_url
      end
      session[:cart_id] = @cart.id
    else
      flash[:danger] = t "pls_login"
      redirect_to login_path
    end
  end

  def update
    @order_item.update_attributes(order_item_params)
    @order_items = @cart.order_details
  end

  def destroy
    unless @order_item.destroy
      flash.now[:danger] = t "can_not_delete_cart"
      redirect_to cart_path
    end
    @order_items = @cart.order_details
    redirect_to cart_path
  end

  def load_item
    @order_item = @cart.order_details.find_by id: params[:id]
    return if @order_item
    flash[:danger] = t "not_found_product"
    redirect_to cart_path
  end

  private

  def order_item_params
    if params[:order_detail].present?
      params.require(:order_detail).permit(:quantity, :product_id)
    else
      {quantity: params[:quantity], product_id: params[:product_id]}
    end
  end
end
