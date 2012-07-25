class MissingMapping

  include Mongoid::Document

  field :old_url, :type => String

  validates_presence_of :old_url
  validates_uniqueness_of :old_url

end
