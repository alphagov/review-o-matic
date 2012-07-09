require 'test_helper'

class BrowseControllerTest < ActionController::TestCase

  setup do
    login_as_stub_user
    current_user = @user
    MigratoratorApi::Mapping.stubs(:find_by_id).returns(MockMigratorator.new)
    MigratoratorApi::Mapping.stubs(:find_random_mapping).returns(MockMigratorator.new)
    @mapping = Mapping.new(:mapping_id => 'testo', :section => "section:directories")
    url = "#{MIGRATORATOR_ENDPOINT}/api/mappings/testo.json"
    stub_request(:get, url).to_return(:status => 200, :body => { "mapping" => @mapping }.to_json, :headers => {})
    @mapping.save!
  end

  should "get the index page of the browse controller" do
    get :index
    assert_response :redirect
  end

  should "get the show page of the browse controller" do
    get(:show, {'id' => @mapping.id})
    assert_response :success
  end

  should "get another review at random if the user has already reviewed that mapping" do
    @mapping.reviews.create!(:user_id => @user.id, :mapping_id => @mapping.id, :result => 'positive')
    get(:show, {'id' => @mapping.id})
    assert_equal 1, @mapping.reviews.count
    assert_not_equal assigns["reviews"], @mapping.reviews.first 
  end

end
