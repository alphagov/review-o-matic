class ExploreController < ApplicationController

  layout 'explore'
  respond_to :html, :json

  rescue_from NoMethodError, :with => :mapping_not_found

  def index
    
  end

  def show
    @mapping = MigratoratorApi::Mapping.find_by_old_url( params[:old_url] )
  end

  private

  def mapping_not_found
    respond_to do |format|
      format.html do |x|
        render 'public/404.html', :status => 404
      end
      format.json do |x|
        render :status => 200, :json => { :status => 404, :message => 'Mapping not found.' }
      end
    end
  end

end
