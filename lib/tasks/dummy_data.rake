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

    users = User.all
    mappings = Mapping.all
    
    rand(mappings.count).times do 
      mapping = mappings[rand(mappings.count)]
      mapping.reviews.create!(:user_id => users[rand(users.count)].id, :mapping_id => mapping.mapping_id, :result => Review::RESULTS[rand(Review::RESULTS.count)])
      mapping.save!
    end

  end

  desc "Create dummy users"
  task :create_dummy_users => :environment do
    @user_1 = User.find_or_create_by(:name => "Ian", :email => "ian.wood@digital.cabinet-office.gov.uk", :authentication_token => 'password')
    @user_2 = User.find_or_create_by(:name => "Winston", :email => "winston@alphagov.co.uk", :authentication_token => 'winston')
    @user_3 = User.find_or_create_by(:name => "John", :email => "john@thebeatles.com", :authentication_token => 'password')
    @user_4 = User.find_or_create_by(:name => "Paul", :email => "paul@thebeatles.com", :authentication_token => 'password')
    @user_5 = User.find_or_create_by(:name => "George", :email => "george@thebeatles.com", :authentication_token => 'password')
    @user_6 = User.find_or_create_by(:name => "Ringo", :email => "ringo@thebeatles.com", :authentication_token => 'password')
    @user_7 = User.find_or_create_by(:name => "Kurt", :email => "kurt@nirvana.com", :authentication_token => 'password')
    @user_8 = User.find_or_create_by(:name => "Dave", :email => "dave@foofighters.com", :authentication_token => 'password')
    @user_9 = User.find_or_create_by(:name => "Mick", :email => "mick@rollingstones.com", :authentication_token => 'password')
    @user_10 = User.find_or_create_by(:name => "Keith", :email => "keith@rollingstones.com", :authentication_token => 'password')
    @user_11 = User.find_or_create_by(:name => "Ziggy", :email => "dave@bowie.com", :authentication_token => 'password')
    @user_12 = User.find_or_create_by(:name => "PJ", :email => "pj@harvey.com", :authentication_token => 'password')
    @user_13 = User.find_or_create_by(:name => "Bob", :email => "bob@marley.com", :authentication_token => 'password')
    @user_14 = User.find_or_create_by(:name => "Liam", :email => "liam@prodigy.com", :authentication_token => 'password')
    @user_15 = User.find_or_create_by(:name => "Damon", :email => "damon@blur.com", :authentication_token => 'password')
    @user_16 = User.find_or_create_by(:name => "Frank", :email => "frank@sinatra.com", :authentication_token => 'password')
    @user_17 = User.find_or_create_by(:name => "Amon", :email => "amon@tobin.com", :authentication_token => 'password')
    @user_18 = User.find_or_create_by(:name => "Kieran", :email => "kieran@fourtet.com", :authentication_token => 'password')
    @user_19 = User.find_or_create_by(:name => "Eddie", :email => "eddie@pearljam.com", :authentication_token => 'password')
    @user_20 = User.find_or_create_by(:name => "Chris", :email => "chris@soundgarden.com", :authentication_token => 'password')
    @user_21 = User.find_or_create_by(:name => "JayZ", :email => "jayz@rockafella.com", :authentication_token => 'password')
  end
  
end
