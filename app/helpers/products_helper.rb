module ProductsHelper
  def show_image_for product
    image_tag(product.picture.url, class: "img-responsive")
  end

  def display_availability_for product
    product.active? ? t("in_stock") : t("nolonger_sold")
  end
end
