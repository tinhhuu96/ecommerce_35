class CartsController < ApplicationController
  def show
    @order_items = current_cart.order_details
  end
end
