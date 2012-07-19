class ExploreController < ApplicationController

  respond_to :html, :json

  #rescue_from NoMethodError, :with => :mapping_not_found

  def show
    @mapping = MigratoratorApi::Mapping.find_by_old_url( params[:old_url] )
    Rails.logger.debug "@mapping instance variable in Explore controller"
    Rails.logger.debug @mapping
    Rails.logger.info "Rails Environment"
    Rails.logger.info Rails.env
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
