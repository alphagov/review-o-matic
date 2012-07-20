class ExploreController < ApplicationController

  respond_to :html, :json

  rescue_from NoMethodError, :with => :mapping_not_found

  def show
    @mapping = MigratoratorApi::Mapping.find_by_old_url( params[:old_url] )
  end

  private

  def mapping_not_found
    respond_to do |format|
      format.html do |x|
        redirect_to(explore_path + "?old_url=http://www.direct.gov.uk/en/index.htm")
      end
      format.json do |x|
        render :status => 200, :json => { :status => 404, :message => 'Mapping not found.' }
      end
    end
  end

end
