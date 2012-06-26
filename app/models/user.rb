class User

  include Mongoid::Document
  field :email, :type => String
  field :score, :type => Integer
  field :name, :type => String
  field :secret, :type => String

  validates_presence_of :email, :message => "can't be blank"
  validates_uniqueness_of :email, :message => "Must be unique" 
  validates_presence_of :name, :message => "can't be blank"

end
