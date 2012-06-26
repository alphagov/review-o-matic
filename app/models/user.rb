class User
  include Mongoid::Document
  field :email, :type => String
  field :score, :type => Integer
  field :name, :type => String
end
