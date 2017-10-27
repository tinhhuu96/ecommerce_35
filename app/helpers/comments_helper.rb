module CommentsHelper
  def show_number_comments_of product
    product.comments.size
  end
end
