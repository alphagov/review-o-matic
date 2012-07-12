class ReviewsController < ApplicationController

  respond_to :json

  def index
    @mappings = Mapping.order_by(:score.asc, :reviews_count.desc).page params[:page]
  end

  def update
    @review = Review.find_or_create_by(mapping_id: params[:id], user_id: current_user.id)
    @review.mapping = Mapping.find_or_create_by(:mapping_id => params[:id]) if @review.mapping.blank?
    @review.result = params[:result]

    @review.save
    respond_with(@review)
  end

  def section
    @reviews = Review.order_by(:mapping_id.desc).page params[:page]
  end

end
