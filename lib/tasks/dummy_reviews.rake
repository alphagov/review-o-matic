namespace :db do

  desc "Create dummy mappings"
  task :create_dummy_mappings => :environment do
    mappings = Mapping.all
    mappings.each do |mapping|
      100.times do |x|
        mapping = Mapping.create!(:mapping_id => mapping.mapping_id)
      end
    end
  end

  desc "Create dummy reviews"
  task :create_dummy_reviews => :environment do
    @user_1 = User.find_or_create_by(:name => "Ian", :email => "ian.wood@digital.cabinet-office.gov.uk", :authentication_token => 'password')
    @user_2 = User.find_or_create_by(:name => "Winston", :email => "winston@alphagov.co.uk", :authentication_token => 'winston')
    mappings = Mapping.all
    
    rand(mappings.count).times do |x|
      mapping = mappings[rand(mappings.count)]
      mapping.reviews.create!(:user_id => @user_1.id, :mapping_id => mapping.mapping_id, :result => Mapping::RESULTS[rand(Mapping::RESULTS.count)])
    end

    rand(mappings.count).times do |x|
      mapping = mappings[rand(mappings.count)]
      mapping.reviews.create!(:user_id => @user_2.id, :mapping_id => mapping.mapping_id, :result => Mapping::RESULTS[rand(Mapping::RESULTS.count)])
    end

  end
  
end
