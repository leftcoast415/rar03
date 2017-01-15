class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @reviews = Review.all
    respond_with(@reviews)
  end

  def show
    respond_with(@review)
  end

  def new
    @review = Review.new
    respond_with(@review)
  end

  def edit
  end

  def create
    @review = Review.new(review_params)
    @review.save
    if @review.save
      redirect_to @review.business, notice: 'Review was successfully submitted.'
    else
      redirect_to business_path(@review.business), notice: @review.errors.full_messages
    end
  end

  def update
    @review.update(review_params)
    respond_with(@review.business)
  end

  def destroy
    @review.destroy
    respond_with(@review.business)
  end

  private
    def set_review
      @review = Review.find(params[:id])
    end

    def review_params
      params.require(:review).permit(:review_text, :review_rating, :business_id, :user_id)
    end
end
