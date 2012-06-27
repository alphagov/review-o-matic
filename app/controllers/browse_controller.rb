class BrowseController < ApplicationController

  layout "browser"

  def index
    @mapping = MigratoratorApi::Mapping.find_random_mapping("status:closed")
    redirect_to browse_mapping_path(@mapping._id)
  end

  def show
    @mapping = MigratoratorApi::Mapping.find_by_id(params[:id])
  end

end