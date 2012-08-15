require 'csv'

class ReviewsController < ApplicationController

  respond_to :json

  def index
    mapping_ids = []
    respond_to do |format|
      format.html do
        @mappings = Mapping.where(:reviews_count.gt => 0).order_by(:reviews_count.desc).page params[:page]
        @mappings.each {|mapping| mapping_ids << mapping.mapping_id.to_s }
        @migratorator_mappings = MigratoratorApi::Mapping.find_by_ids(mapping_ids.join(','))
      end
      format.csv do 
        mapping_ids_collections = []
        @mappings = Mapping.where(:reviews_count.gt => 0).order_by(:reviews_count.desc)
        @mappings.each {|mapping| mapping_ids << mapping.mapping_id.to_s }

        # MigratoratorApi::Mapping.find_by_ids(collection.join(',')) has to be limited to 50 ids as there is a limit to the size of the query string. This makes multiple API calls and then merges the results. Could be refactored.
        ((mapping_ids.count / 50) + 1).times do
          mapping_ids_collections << mapping_ids.shift(50)
        end
        @migratorator_mappings = {} 
        mapping_ids_collections.each do |collection|
          @migratorator_mappings.merge!(MigratoratorApi::Mapping.find_by_ids(collection.join(',')))
        end

        @reviews = Review.order_by(:mapping_id.desc)
        
        csv = CSV.generate do |csv|
          csv << ["User", "Old Url", "New Url", "Comment"]
          @reviews.each do |review|
            if !@migratorator_mappings[review.mapping.mapping_id].nil?
              csv << [review.user.email, @migratorator_mappings[review.mapping.mapping_id]['old_url'], @migratorator_mappings[review.mapping.mapping_id]['new_url'], review.comment]
            end
          end
        end
        send_data(csv, :type => 'test/csv', :filename => 'Mapping_Reviews.csv') 
      end
    end

  end

  # Custom create route which requires an :id parameter for explorer view
  def create
    @mapping = Mapping.find_or_create_by(conditions: {mapping_id: params[:id]})
    @review = Review.find_or_initialize_by(:mapping_id =>  @mapping.id, :user_id => current_user.id)
    @review.comment = params[:comment]
    @review.save
    respond_with(@review)
  end

  def update
    @review = Review.find_or_create_by(mapping_id: params[:id], user_id: current_user.id)
    @review.mapping = Mapping.find_or_create_by(:mapping_id => params[:id]) if @review.mapping.blank?
    @review.result = params[:result]
    @review.save
    respond_with(@review)
  end

  def section
    @reviews = Review.order_by(:mapping_id.desc).page params[:page]
  end

end
