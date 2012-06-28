class BrowseController < ApplicationController

  layout "browser"

  respond_to :html, :json

  def index
    @mapping = MigratoratorApi::Mapping.find_random_mapping("status:closed")
    puts @mapping.inspect
    puts @mapping.id

    respond_to do |format|
      format.html { redirect_to browse_mapping_path(@mapping.id) }
      format.json { render :json => { :next_mapping_id => @mapping.id } }
    end
  end

  def show
    @mapping = MigratoratorApi::Mapping.find_by_id(params[:id])
    @review = Review.where(:mapping_id => @mapping.id, :user_id => current_user.id).first
  end

end