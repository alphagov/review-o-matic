require 'test_helper'

class MissingMappingTest < ActiveSupport::TestCase

  should_not allow_value(nil).for(:old_url)

  should "be a unique url" do
    @missing_mapping_1 = MissingMapping.create!(:old_url => 'test')
    @missing_mapping_2 = MissingMapping.new(:old_url => 'test')
    assert_equal false, @missing_mapping_2.valid?
  end

end
