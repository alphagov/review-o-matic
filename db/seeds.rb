# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

@user_1 = User.find_or_create_by(:name => "Ian", :email => "ian.wood@digital.cabinet-office.gov.uk", :authentication_token => 'password')
@user_2 = User.find_or_create_by(:name => "Winston", :email => "winston@alphagov.co.uk", :authentication_token => 'winston')

@closed_tags = MigratoratorApi::Mapping.all_by_tag('status:closed')

@closed_tags.each do |mapping_from_api|
  mapping = Mapping.create!(:mapping_id => mapping_from_api.id)
  mapping.reviews.create!(:user_id => @user_1.id, :mapping_id => mapping.mapping_id, :result => "positive")
  mapping.reviews.create!(:user_id => @user_2.id, :mapping_id => mapping.mapping_id, :result => "negative")
end
