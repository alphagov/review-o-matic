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

  after_create :set_user_score

  def set_user_score
    self.user.set_score
    self.user.save
  end

end
