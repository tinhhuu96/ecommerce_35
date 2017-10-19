class OrdersController < ApplicationController
  before_action :load_order, only: %i(show update update_quantity_product)

  def show
    @order_items = @order.order_details
    return if @order_items
    flash[:danger] = t "not_found_order-details"
  end

  def update
    if @order.cancelled!
      update_quantity_product
      flash[:success] = t "cancel_order"
    else
      flash[:danger] = t "canel_order_error"
    end
    redirect_to order_path
  end

  private

  def load_order
    @order = Order.find_by id: params[:id]
    return if @order
    flash[:danger] = t "not_found_order"
    redirect_to my_orders_path
  end

  def load_product product_id
    @product = Product.find_by id: product_id
    return if @product
    flash[:danger] = t "not_found_product"
    redirect_to my_orders_path
  end

  def update_quantity_product
    @order.order_details.each do |item|
      load_product item.product_id
      quantity = item.quantity + @product.quantity
      unless @product.update_attributes quantity: quantity
        flash[:danger] = t "update_quantity_errors"
        redirect_to my_orders_path
      end
    end
  end
end
