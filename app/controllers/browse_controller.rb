class BrowseController < ApplicationController
  respond_to :html, :json
  before_filter :gds_user?

  def index
    @tags = ["status:closed","destination:content"]
    @mapping = MigratoratorApi::Mapping.find_random_mapping(@tags.join(','))
    @reviews = Review.where(:user_id => current_user.id, :mapping_id => @mapping.id) 
    @total_mappings_count = MigratoratorApi::Mapping.count_all_mappings
    while @reviews.count > 0 && current_user.reviews.count <= @total_mappings_count
      @mapping = MigratoratorApi::Mapping.find_random_mapping(@tags.join(','))
      @reviews = Review.where(:user_id => current_user.id, :mapping_id => @mapping.id) 
    end
    respond_to do |format|
      format.html { redirect_to browse_mapping_path(@mapping.id, :section => @section) }
      format.json { render :json => { :next_mapping_id => @mapping.id, :section => @section } }
    end
  end

  def show
    @mapping = MigratoratorApi::Mapping.find_by_id(params[:id])
    @section = params[:section].to_s
    @review = Review.where(:mapping_id => @mapping.id, :user_id => current_user.id).first
  end

end
