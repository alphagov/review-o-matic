class ReviewsController < ApplicationController

  respond_to :json

  def update
    @review = Review.find_or_create_by(mapping_id: params[:id], user_id: current_user.id)
    @review.result = params[:result]

    @review.save
    respond_with(@review)
  end

end