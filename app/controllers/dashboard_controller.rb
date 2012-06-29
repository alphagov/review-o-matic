require 'migratorator_api'

class DashboardController < ApplicationController

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
      end
    end

  end

  def mosaic
    respond_to do |format|
      format.html do |x|

      end
      format.js do |x|
        @mappings = Mapping.all
      end
    end
  end

end
