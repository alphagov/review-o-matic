require 'test_helper'

class ExploreControllerTest < ActionController::TestCase

  setup do
    login_as_gds_stub_user
  end

  should "get the show page of the explore controller" do
    MigratoratorApi::Mapping.stubs(:find_by_old_url).returns(MockMigratorator.new)
    get :show
    assert_response :success
  end

  should "get the show page and return JSON if record is not found and format is JSON" do
    MigratoratorApi::Mapping.stubs(:find_by_old_url).returns(false)
    get :show, format: 'json'
    assert_response :success
    assert_equal JSON.generate({ :status => 404, :message => 'Mapping not found.' }), @response.body
  end

end
