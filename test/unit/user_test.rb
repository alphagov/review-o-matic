require 'test_helper'

class UserTest < ActiveSupport::TestCase

  setup do
    @user_1 = User.find_or_create_by(:name => "Ian", :email => "ian.wood@digital.cabinet-office.gov.uk", :authentication_token => 'password')
  end

  should "return true when running gds_user? if the users email is a gds email" do
    assert_equal true, @user_1.gds_user?
  end

  should "return false when running gds_user? if the users email is not a gds email" do
    @user_1.email = "ian@notgds.com"
    assert_equal false, @user_1.gds_user?
  end

end
