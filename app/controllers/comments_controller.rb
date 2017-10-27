class CommentsController < ApplicationController
  before_action :logged_in_user, only: %i(destroy create)

  def create
    @comment = current_user.comments.build comment_params
    if @comment.save
      flash[:success] = t ".comment_created"
      redirect_to @comment.product
    else
      flash[:danger] = t ".comment_not_created"
      redirect_to request.referer || root_url
    end
  end

  def destroy
    @comment = current_user.comments.find_by id: params[:id]
    if @comment.destroy
      flash[:success] = t "deleted"
    else
      flash[:success] = t "not_deleted"
      redirect_to request.referer || root_url
    end
  end

  private

  def comment_params
    params.require(:comment).permit :content, :product_id
  end
end
