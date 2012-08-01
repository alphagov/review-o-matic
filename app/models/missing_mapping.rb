class MissingMapping

  include Mongoid::Document

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

end
