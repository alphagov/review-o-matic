class Review
  include Mongoid::Document
  belongs_to :mapping
  belongs_to :user
  field :user_id, :type => String
  field :mapping_id, :type => String
  field :result, :type => String

  RESULTS = [
    'positive',
    'neutral',
    'negative'
  ]

  validates :user_id, :mapping_id, :result, :presence => true
  validates :result, :inclusion => { :in => RESULTS }

  after_save :set_user_score
  after_save :set_mapping_score

  def mapping
    @mapping ||= Mapping.find_or_create_by(:mapping_id => mapping_id)
  end

  def set_user_score
    self.user.set_score!
  end

  def set_mapping_score
    mapping.set_score!
  end


end
