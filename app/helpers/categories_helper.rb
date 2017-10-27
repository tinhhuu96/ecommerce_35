module CategoriesHelper
  def load_product_in_cate category
    @products = category.products
  end

  def display_cate_name_by id
    @cate = Category.find_by(id: id)
    @cate.present? ? @cate.name : id
  end
end
