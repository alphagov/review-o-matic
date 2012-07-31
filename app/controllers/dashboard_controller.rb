require 'migratorator_api'
class DashboardController < ApplicationController

  skip_before_filter :authenticate_user!

  def index

    respond_to do |format|
      format.html do |x|

      end
      format.js do |x|
        @mappings = Mapping.all
        @reviewed_mappings_count = Mapping.where(:reviews_count.gt => 0).count
        @green_mappings = @mappings.where(:score.gt => "80")
        @amber_mappings = @mappings.where(:score.lt => "80", :score.gt => "20")
        @red_mappings = @mappings.where(:score.lt => "20")
        @users = User.desc(:score).limit(20)
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
        @sections = MigratoratorApi::Tag.all_by_group("section").map {|section|
          reviewed_mappings_for_section = Mapping.where(:section => section.name, :reviews_count.gt => 0).count
          unreviewed_mappings_for_section = section.count.to_i
          { :name => section.name, :reviewed => reviewed_mappings_for_section, :unreviewed => unreviewed_mappings_for_section }
        }
      end
    end
  end
 
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
