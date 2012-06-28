class Mapping

  include Mongoid::Document

  before_save :set_score

  field :mapping_id, :type => String
  field :score, :type => String
  field :section, :type => String

  has_many :reviews

  validates :mapping_id, :presence => true

  def set_score
    reviews_count = self.reviews.count
    yes_reviews_count = self.reviews.where(:result => "yes").count
    self.score = yes_reviews_count.percent_of(reviews_count)
  end

  def set_section
    section = []
    mapping = MigratoratorApi::Mapping.find_by_id(self.mapping_id)  
    mapping.tags.each do |tag|
      section << tag.scan(/section:\w+/)
    end
    section.flatten!
    if section[0] != nil
      self.section = section[0].sub(/^section:/, '')
    end
  end

end
