class RatingsController < ApplicationController
  before_action :logged_in_user, only: %i(destroy create)
  before_action :load_review, only: :destroy

  def create
    @review = current_user.ratings.build rating_params
    @review.score = params[:rating_val]
    if @review.save
      flash[:success] = t ".rating_created"
      redirect_to @review.product
    else
      flash[:danger] = t ".rating_not_created"
      redirect_to request.referer || root_url
    end
  end

  def destroy
    if @review.destroy
      flash[:success] = t "deleted"
    else
      flash[:success] = t "not_deleted"
      redirect_to request.referer || root_url
    end
  end

  private

  def load_review
    @review = current_user.ratings.find_by id: params[:id]
    return if @review
    flash[:danger] = t "cant_find_review"
    redirect_to request.referer || root_url
  end

  def rating_params
    params.require(:rating).permit :content, :product_id, :score
  end
end
