class User

  include Mongoid::Document
  field :email, :type => String
  field :score, :type => Integer
  field :name, :type => String

  validates_presence_of :email, :message => "can't be blank"
  validates_presence_of :name, :message => "can't be blank"

end
