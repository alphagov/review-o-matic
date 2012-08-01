require 'test_helper'

class MissingMappingTest < ActiveSupport::TestCase

  should_not allow_value(nil).for(:old_url)

  should "be a unique url" do
    @missing_mapping_1 = MissingMapping.create!(:old_url => 'test')
    @missing_mapping_2 = MissingMapping.new(:old_url => 'test')
    assert_equal false, @missing_mapping_2.valid?
  end

  should "validate as false any missing mapping that is a DirectGov Advanced Search result" do
    @missing_mapping_starts_with_search = MissingMapping.new(:old_url => 'http://www.direct.gov.uk/en/AdvancedSearch/Searchresults/index.htm')
    assert_equal true, @missing_mapping_starts_with_search.valid?
  
    @missing_mapping_ends_with_results = MissingMapping.new(:old_url => 'http://www.direct.gov.uk/en/test/results')
    assert_equal true, @missing_mapping_ends_with_results.valid?
  
    @missing_mapping_starts_with_search_and_ends_in_results = MissingMapping.new(:old_url => 'http://www.direct.gov.uk/en/AdvancedSearch/Searchresults/results')
    assert_equal false, @missing_mapping_starts_with_search_and_ends_in_results.valid?
  end

  should "validate as true the DirectGov Advanced Search index page" do
    @missing_mapping_search_index = MissingMapping.new(:old_url => 'http://www.direct.gov.uk/en/AdvancedSearch/Searchresults/index.htm')
    assert_equal true, @missing_mapping_search_index.valid?
  end

end
