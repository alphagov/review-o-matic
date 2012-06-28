require 'migratorator_api'

class DashboardController < ApplicationController

  def index

    respond_to do |format|
      format.html do |x|
        @open_tags = ::MigratoratorApi::Mapping.all_by_tag('status:open') 
        @closed_tags = ::MigratoratorApi::Mapping.all_by_tag('status:closed') 
        @all_tags_count = @open_tags.count + @closed_tags.count
      end
      format.js do |x|
        @mappings = Mapping.all
      end
    end

  end

end
