class ReviewsController < ApplicationController
  before_action :ensure_user
  before_action :get_product

  def create

    @review = @product.reviews.new(review_params)
    unless @review.save
      flash[:danger] = @review.errors.full_messages
    end    
    redirect_to product_path(@product)
  end

  def destroy
    @review = Review.find params[:id]
    if @review.user_id == @user.id
      @review.destroy
      redirect_to product_path(@product), notice: 'Review deleted!'
    end
  end

  private

  def review_params
    my_params = params.require(:review)
    my_params[:user_id] = session[:user_id]
    my_params.permit(
      :rating,
      :description,
      :user_id
    )
  end

  def ensure_user
    redirect_to :root unless @user
  end

  def get_product
    product_id = params["product_id"]
    @product = Product.find(product_id)
  end
end
