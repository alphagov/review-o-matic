require 'migratorator_api'
class DashboardController < ApplicationController

  skip_before_filter :authenticate_user!
 
  def missing_mappings
    respond_to do |format|
      format.html do |x|

      end
      format.js do |x|
        @missing_mappings = MissingMapping.desc(:old_url)
      end
    end
  end

end
