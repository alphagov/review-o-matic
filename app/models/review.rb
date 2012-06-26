class Review
  include Mongoid::Document
  field :user_id, :type => Integer
  field :mapping_id, :type => String
  field :result, :type => String
end
