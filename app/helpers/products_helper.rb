module ProductsHelper
  def show_image_for product
    image_tag(product.picture.url, class: "img-responsive")
  end

  def display_availability_for product
    product.active? ? t("in_stock") : t("nolonger_sold")
  end

  def bought_this_product_before?
    if logged_in?
      if (@ordered_list = current_user.orders.ids).present?
        @ordered_list.each do |item|
          @check = current_user.orders.find(item).order_details.find_by product_id: params[:id]
          break if @check.present?
        end
      end
      @check.present?
    else false
    end
  end

  def review_this_product_before?
    if logged_in?
      @check = current_user.ratings.find_by product_id: params[:id]
      @check.present?
    else
      false
    end
  end
end
