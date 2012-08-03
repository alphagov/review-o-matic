namespace :db do

  desc "Updates the review count for all mappings"
  task :update_review_count => :environment do
    @mappings = Mapping.all
    @mappings.each {|mapping| mapping.set_reviews_count! }
  end

end
