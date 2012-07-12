require 'test_helper'

class ReviewTest < ActiveSupport::TestCase

  setup do
    @user_1 = User.find_or_create_by(:name => "Ian", :email => "ian.wood@digital.cabinet-office.gov.uk", :authentication_token => 'password')
    migratorator_has_mapping({ 'id' => "example",  "tags" => [ "section:example" ] })
  end

  should_not allow_value(nil).for(:mapping_id)
  should_not allow_value(nil).for(:user_id)
  should_not allow_value(nil).for(:result)

  should allow_value('positive').for(:result)
  should allow_value('negative').for(:result)

  should "Set a score for the user" do
    @review_1 = Review.create(:user_id => @user_1.id, :mapping_id => "example", :result => "positive")
    @review_1.set_user_score
    assert_equal 1, @review_1.user.score
  end

end
