class BrowseController < ApplicationController
  respond_to :html, :json

  def index
    @section = params[:section].blank? ? params[:section].to_s : nil
    @tags = ["status:closed","destination:content"]
    @mapping = MigratoratorApi::Mapping.find_random_mapping(@tags.join(','))

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
