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

  should "be invalid if name is not present" do
    @user_2 = User.find_or_create_by(:email => "testo@digital.cabinet-office.gov.uk", :authentication_token => 'password_2')
    assert_equal false, @user_2.valid?
  end

  should "be invalid if email is not present" do
    @user_3 = User.find_or_create_by(:name => "Bob", :authentication_token => 'password_3')
    assert_equal false, @user_3.valid?
  end

  should "be invalid if email is not unique" do
    @user_4 = User.find_or_create_by(:name => "Ian", :email => "ian.wood@digital.cabinet-office.gov.uk", :authentication_token => 'password_4')
    assert_equal false, @user_4.valid?
  end

  should "be invalid if the authentication token is not unique" do
    @user_5 = User.new(:name => "Darth", :email => "darth@thedeathstar.com", :authentication_token => "password")
    assert_equal false, @user_5.valid?
  end

end
