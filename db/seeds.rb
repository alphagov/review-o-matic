# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(:name => "Ian", :email => "ian.wood@digital.cabinet-office.gov.uk", :authentication_token => 'password')
User.create(:name => "Jordan", :email => "jordan.hatch@digital.cabinet-office.gov.uk", :authentication_token => 'password')

@closed_tags = ::MigratoratorApi::Mapping.all_by_tag('status:closed') 
@user_1 = User.first(conditions: {name: "Ian"})
@user_2 = User.first(conditions: {name: "Jordan"})

@closed_tags.each do |tag|
  Review.create(:user_id => @user_1.id, :mapping_id => tag["mapping"]["id"], :result => "yes")
  Review.create(:user_id => @user_2.id, :mapping_id => tag["mapping"]["id"], :result => "no")
end
