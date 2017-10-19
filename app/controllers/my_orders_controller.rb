class MyOrdersController < ApplicationController
  def index
    @orders = current_user.orders.sort_by_created
  end
end
