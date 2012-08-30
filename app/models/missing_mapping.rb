class MissingMapping

  include Mongoid::Document
  include Mongoid::Timestamps

  field :old_url, :type => String

  validates_presence_of :old_url
  validates_uniqueness_of :old_url
  validate :direct_gov_url_validation, :if => proc { !self.old_url.nil? }

  def direct_gov_url_validation
    advanced_search_starting_string = 'http://www.direct.gov.uk/en/AdvancedSearch/'
    advanced_search_results = '/results'
    if old_url.match(/^#{advanced_search_starting_string}{1}.*#{advanced_search_results}{1}$/)
      errors.add(:old_url, 'This url is the results of a Directgov Advanced Search so does not require a mapping on GOV.UK')
    end
  end

  def self.purge_mappings_which_are_no_longer_missing!
    mappings_no_longer_missing = MigratoratorApi::Mapping.find_by_old_urls(MissingMapping.missing_mappings_joined)
    old_urls = []
    mappings_no_longer_missing.each_key { |key| old_urls << key }
    MissingMapping.any_in( old_url: old_urls ).delete_all
  end

  def self.missing_mappings_joined
    mapping_urls = []
    all.each { | mapping |  mapping_urls << mapping.old_url }
    mapping_urls.join(',')
  end
end
