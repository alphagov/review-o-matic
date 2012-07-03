require 'test_helper'

class MappingTest < ActiveSupport::TestCase

  setup do
    @user_1 = User.find_or_create_by(:name => "Ian", :email => "ian.wood@digital.cabinet-office.gov.uk", :authentication_token => 'password')
    @user_2 = User.find_or_create_by(:name => "Winston", :email => "winston@alphagov.co.uk", :authentication_token => 'winston')

    migratorator_has_mapping({ 'id' => "example",  "tags" => [ "section:example" ] })
  end

  should_not allow_value(nil).for(:mapping_id)

  should "set the score based on the number of reviews 50.0 with 1 positive and 1 negative" do
    mapping = Mapping.create!(:mapping_id => "example")
    mapping.reviews.create!(:user_id => @user_1.id, :mapping_id => mapping.mapping_id, :result => "positive")
    mapping.reviews.create!(:user_id => @user_2.id, :mapping_id => mapping.mapping_id, :result => "negative")
    mapping.save
    assert_equal 50.0, mapping.score
  end

  should "set the score based on the number of reviews 100.0 with 1 positive" do
    mapping = Mapping.create!(:mapping_id => "example")
    mapping.reviews.create!(:user_id => @user_1.id, :mapping_id => mapping.mapping_id, :result => "positive")
    mapping.save
    assert_equal 100.0, mapping.score
  end

  should "set the score based on the number of reviews 0.0 with 1 negative" do
    mapping = Mapping.create!(:mapping_id => "example")
    mapping.reviews.create!(:user_id => @user_2.id, :mapping_id => mapping.mapping_id, :result => "negative")
    mapping.save
    assert_equal 0.0, mapping.score
  end

end
