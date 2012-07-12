class Review
  include Mongoid::Document
  belongs_to :mapping, :foreign_key => "mapping_id"
  belongs_to :user

  field :user_id, :type => String
  field :mapping_id, :type => String
  field :result, :type => String
  field :comment, :type => String

  RESULTS = [
    'positive',
    'negative'
  ]

  validates :user_id, :mapping_id, :result, :presence => true
  validates :result, :inclusion => { :in => RESULTS }

  before_create :ensure_mapping_exists, :if => proc { self.mapping.blank? }

  after_save :set_user_score
  after_save :set_mapping_score
  after_save :set_mapping_reviews_count

  def set_user_score
    self.user.set_score!
  end

  def set_mapping_score
    mapping.set_score!
  end

  def set_mapping_reviews_count
    mapping.set_reviews_count!
  end

  def ensure_mapping_exists
    self.mapping = Mapping.find_or_create_by(:mapping_id => self.mapping_id)
  end

end
