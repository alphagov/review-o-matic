class Review
  include Mongoid::Document
  belongs_to :mapping, :foreign_key => "mapping_id"
  belongs_to :user

  field :user_id, :type => String
  field :mapping_id, :type => String
  field :comment, :type => String

  validates :user_id, :mapping_id, :presence => true

  validate :unique_mapping_and_user_validator, :on  => :create

  before_create :ensure_mapping_exists, :if => proc { self.mapping.blank? }

  after_save :set_mapping_reviews_count

  def set_mapping_reviews_count
    mapping.set_reviews_count!
  end

  def ensure_mapping_exists
    self.mapping = Mapping.find_or_create_by(:mapping_id => self.mapping_id)
  end

  def unique_mapping_and_user_validator
    if Review.first(conditions: {mapping_id: self.mapping_id, user_id: self.user_id})
      errors.add(:base, "This user has already submitted a review for this mapping.")
    end
  end

end
