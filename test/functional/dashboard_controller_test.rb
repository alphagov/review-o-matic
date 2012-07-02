require 'test_helper'

class DashboardControllerTest < ActionController::TestCase

  setup do
    login_as_stub_user
  end

  should "get the index page of the dashboard controller" do
    get :index
    assert_response :success
  end

  should "get the mosaic page of the dashboard controller" do
    get :mosaic
    assert_response :success
  end

end
