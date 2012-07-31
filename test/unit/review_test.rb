require 'test_helper'

class ReviewTest < ActiveSupport::TestCase

  setup do
    @user_1 = User.find_or_create_by(:name => "Ian", :email => "ian.wood@digital.cabinet-office.gov.uk", :authentication_token => 'password')
    migratorator_has_mapping({ 'id' => "test_mapping_1",  "tags" => [ "section:example" ] })
    @mapping_1 = Mapping.new(:mapping_id => 'testo', :section => "section:directories")
    url = "#{MIGRATORATOR_ENDPOINT}/api/mappings/testo.json"
    stub_request(:get, url).to_return(:status => 200, :body => { "mapping" => @mapping_1 }.to_json, :headers => {})
    migratorator_has_mapping({ 'id' => "#{@mapping_1.id}",  "tags" => [ "section:example" ] })
    @mapping_1.stubs(:set_section).returns("example")
    @mapping_1.stubs(:set_reviews_count!).returns(true)
    @mapping_1.save
  end

  should_not allow_value(nil).for(:mapping_id)
  should_not allow_value(nil).for(:user_id)

  should "be invalid if the user has already reviewed the mapping" do
    @review_1 = Review.create(:user_id => @user_1.id, :mapping_id => @mapping_1.id)
    @review_2 = Review.new(:user_id => @user_1.id, :mapping_id => @mapping_1.id)
    assert_equal false, @review_2.valid?
  end

end
