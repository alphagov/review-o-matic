class ReviewsController < ApplicationController

  respond_to :json

  def index
    @mappings = Mapping.asc(:score).limit(40)
  end

  def update
    @review = Review.find_or_create_by(mapping_id: params[:id], user_id: current_user.id)
    @review.mapping = Mapping.find_or_create_by(:mapping_id => params[:id])
    @review.result = params[:result]

    @review.save
    respond_with(@review)
  end

end
