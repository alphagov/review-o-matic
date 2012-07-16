class ReviewsController < ApplicationController

  respond_to :json

  def index
    @mappings = Mapping.order_by(:score.asc, :reviews_count.desc).page params[:page]
  end

  # Custom create route which requires an :id parameter for explorer view
  def create
    @review = Review.find_or_create_by(mapping_id: params[:id], user_id: current_user.id)
    @review.mapping = Mapping.find_by(:mapping_id => params[:id]) if @review.mapping.blank?
    @review.comment = params[:comment]
    @review.save
    respond_with(@review)
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
