require 'migratorator_api'
class DashboardController < ApplicationController

  skip_before_filter :authenticate_user!
 
  def missing_mappings
    MissingMapping.purge_mappings_which_are_no_longer_missing!
    
    respond_to do |format|
      format.html do |x|

      end
      format.json do |x|
        @missing_mappings = MissingMapping.desc(:old_url)
        render :json => @missing_mappings 
      end

    end
  end

end
