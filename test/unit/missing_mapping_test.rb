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

  should "be able to return all the missing mappings' old_urls as a string joined by commas..." do
    @missing_mapping_1 = MissingMapping.create!(:old_url => 'test_1')
    @missing_mapping_2 = MissingMapping.create!(:old_url => 'test_2')
    @missing_mapping_3 = MissingMapping.create!(:old_url => 'test_3')

    assert_equal "test_1,test_2,test_3", MissingMapping.missing_mappings_joined
  end

  should "purge missing mappings that have subsequently been updated in the migratorator" do
    MissingMapping.create!(:old_url => 'test_1')
    MissingMapping.create!(:old_url => 'test_2')
    MissingMapping.create!(:old_url => 'test_3')
    stub_request(:get, "http://migratorator.test.gov.uk/api/mappings/by_old_url_array.json?old_url_array=test_1,test_2,test_3").
    with(:headers => {'Accept'=>'*/*', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'Ruby'}).
    to_return(:status => 200, :body => '{ "test_2":{} }', :headers => {})
    MissingMapping.purge_mappings_which_are_no_longer_missing!
    @mappings = MissingMapping.all

    assert_equal 2, @mappings.count
    assert MissingMapping.first(conditions: {old_url: 'test_1'})
    assert_nil MissingMapping.first(conditions: {old_url: 'test_2'})
    assert MissingMapping.first(conditions: {old_url: 'test_3'})
  end

end
