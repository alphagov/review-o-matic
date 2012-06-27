class Review
  include Mongoid::Document
  field :user_id, :type => Integer
  field :mapping_id, :type => String
  field :result, :type => String

  RESULTS = [
    :positive,
    :neutral,
    :negative
  ]

  validates :user_id, :mapping_id, :result, :presence => true
  validates :result, :inclusion => { :in => RESULTS }
end
