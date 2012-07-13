class ExploreController < ApplicationController

  respond_to :html, :json

  def show
    @old_url = params[:old_url]
    @mapping = MigratoratorApi::Mapping.find_by_old_url(@old_url).first
    #@review = Review.where(:mapping_id => @mapping.id, :user_id => current_user.id).first
  end

end
