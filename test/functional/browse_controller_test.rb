require 'test_helper'

class BrowseControllerTest < ActionController::TestCase

  context "GDS User tests" do
    setup do
      login_as_gds_stub_user
      current_user = @user
      MigratoratorApi::Mapping.stubs(:find_by_id).returns(MockMigratorator.new)
      MigratoratorApi::Mapping.stubs(:find_random_mapping).returns(MockMigratorator.new)
      MigratoratorApi::Mapping.stubs(:count_all_mappings).returns(3)
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

    should "display the review that has been ranndomly selected if it has not been reviewed by the user before" do
      get(:show, {'id' => @mapping.id})
      assert_equal 0, @mapping.reviews.count
    end

    should "get another review at random if the user has already reviewed that mapping" do
      @mapping.reviews.create!(:user_id => @user.id, :mapping_id => @mapping.id, :result => 'positive')
      get :index
      assert_equal 1, @mapping.reviews.count
      assert_not_equal assigns["reviews"], @mapping.reviews.first 
    end

    should "stop randomly selecting a mapping when the total number of reviews that the user has made equals the total number of mappings" do
      @mapping.reviews.create!(:user_id => @user.id, :mapping_id => @mapping.id, :result => 'positive')
      @mapping_2 = Mapping.new(:mapping_id => 'testo_2', :section => "section:directories")
      url_2 = "#{MIGRATORATOR_ENDPOINT}/api/mappings/testo_2.json"
      stub_request(:get, url_2).to_return(:status => 200, :body => { "mapping" => @mapping_2 }.to_json, :headers => {})
      @mapping_2.save!
      @mapping_2.reviews.create!(:user_id => @user.id, :mapping_id => @mapping_2.id, :result => 'positive')
      @mapping_3 = Mapping.new(:mapping_id => 'testo_3', :section => "section:directories")
      url_3 = "#{MIGRATORATOR_ENDPOINT}/api/mappings/testo_3.json"
      stub_request(:get, url_3).to_return(:status => 200, :body => { "mapping" => @mapping_3 }.to_json, :headers => {})
      @mapping_3.save!
      @mapping_3.reviews.create!(:user_id => @user.id, :mapping_id => @mapping_3.id, :result => 'positive')
      get :index
      assert_equal 3, @user.reviews.count
      assert_response :redirect
    end
  end

  context "Non GDS User tests" do

    setup do
      login_as_nongds_stub_user
      current_user = @user
      MigratoratorApi::Mapping.stubs(:find_by_id).returns(MockMigratorator.new)
      MigratoratorApi::Mapping.stubs(:find_random_mapping).returns(MockMigratorator.new)
      MigratoratorApi::Mapping.stubs(:count_all_mappings).returns(3)
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
      assert_response :redirect
    end

  end

end
