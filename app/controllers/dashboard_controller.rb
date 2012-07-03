require 'migratorator_api'
class DashboardController < ApplicationController

  layout 'dashboard'
  skip_before_filter :authenticate_user!

  def index

    respond_to do |format|
      format.html do |x|

      end
      format.js do |x|
        @mappings = Mapping.all
        @green_mappings = @mappings.where(:score.gt => "80")
        @amber_mappings = @mappings.where(:score.lt => "80", :score.gt => "20")
        @red_mappings = @mappings.where(:score.lt => "20")
        @users = User.desc(:score).limit(10)
        @reviews = Review.all
        @total_mappings_count = MigratoratorApi::Mapping.count_all_mappings 
      end
    end

  end

  def mosaic
    respond_to do |format|
      format.html do |x|

      end
      format.js do |x|
        @sections = {}
        @mappings = Mapping.all
        @s = MigratoratorApi::Tag.all_by_group("section")
        @s.each do |section|
          @sections[section.name] = []
          reviews = @mappings.where(:section => section.name)
          unreviewed_count = (section.count - reviews.count)
          @sections[section.name] << unreviewed_count
          @sections[section.name] << reviews
        end
      end
    end
  end

end
