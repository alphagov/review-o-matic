require 'migratorator_api'
class DashboardController < ApplicationController
  def index
    @users = User.all
    @open_tags = ::MigratoratorApi::Mapping.all_by_tag('status:open') 
    @closed_tags = ::MigratoratorApi::Mapping.all_by_tag('status:closed') 
    @all_tags_count = @open_tags.count + @closed_tags.count
    @reviews = Review.all
    @mappings = [] 
    @closed_tags.each do |tag|
      reviews = @reviews.where(mapping_id: tag["mapping"]["id"])
      yes_reviews = reviews.where(result: "yes")
      @mappings << percent_of(yes_reviews.count, reviews.count)
    end
  end
end
