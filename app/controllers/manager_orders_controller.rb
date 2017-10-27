class ManagerOrdersController < ApplicationController
  before_action :load_order, only: %i(show destroy update)
  def index
    @orders = Order.sort_by_created.paginate(page: params[:page], per_page: Settings.per_page_order)
  end

  def show
    @order_items = @order.order_details
  end

  def destroy
    if @order.destroy
     flash[:success] = t "deleted_order"
    else
      flash[:danger] = t "delete_order_errors"
    end
    redirect_to manager_orders_path
  end

  def update
    if params[:status].present? && params[:status] != @order.status
      @order.update_attributes(status: params[:status])
      UserNotifierMailer.send_mail_status(@order.email, @order).deliver_now
      flash[:success] = "update status success, check mail for you !"
    else
      flash[:danger] = "update status errors"
    end
    redirect_to manager_orders_path
  end

  private

  def load_order
    @order = Order.find_by id: params[:id]
    return if @order
    flash[:danger] = t "not_found_order"
    redirect_to manager_orders_path
  end
end
