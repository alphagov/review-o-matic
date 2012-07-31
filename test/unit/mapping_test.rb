require 'test_helper'

class MappingTest < ActiveSupport::TestCase

  setup do
    @user_1 = User.find_or_create_by(:name => "Ian", :email => "ian.wood@digital.cabinet-office.gov.uk", :authentication_token => 'password')
    @user_2 = User.find_or_create_by(:name => "Winston", :email => "winston@alphagov.co.uk", :authentication_token => 'winston')

    migratorator_has_mapping({ 'id' => "example",  "tags" => [ "section:example" ] })
  end

  should_not allow_value(nil).for(:mapping_id)

end
