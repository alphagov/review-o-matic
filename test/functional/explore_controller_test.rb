require 'test_helper'

class ExploreControllerTest < ActionController::TestCase

  setup do
    login_as_stub_user
    MigratoratorApi::Mapping.stubs(:find_by_old_url).returns(MockMigratorator.new)
  end

  should "get the show page of the explore controller" do

  end



end
