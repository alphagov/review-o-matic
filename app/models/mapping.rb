class Mapping
  include Mongoid::Document
  before_save :set_score
  field :mapping_id, :type => String
  field :score, :type => String
  field :section, :type => String
  has_many :reviews

  def set_score
    reviews_count = self.reviews.count
    yes_reviews_count = self.reviews.where(:result => "yes").count
    self.score = yes_reviews_count.percent_of(reviews_count)
  end
end
