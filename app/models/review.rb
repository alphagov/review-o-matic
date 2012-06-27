class Review
  include Mongoid::Document
  field :user_id, :type => String
  field :mapping_id, :type => String
  field :result, :type => String
  
  validates_presence_of :user_id, :message => "can't be blank"
  validates_presence_of :mapping_id, :message => "can't be blank"

end
