class User

  include Mongoid::Document

  devise :token_authenticatable, :rememberable, :trackable

  field :email, :type => String
  field :score, :type => Integer
  field :name, :type => String

  field :authentication_token,  :type => String
  field :current_sign_in_at,    :type => DateTime
  field :last_sign_in_at,       :type => DateTime
  field :current_sign_in_ip,    :type => String
  field :last_sign_in_ip,       :type => String
  field :sign_in_count,         :type => Integer
  field :remember_created_at,   :type => DateTime

  validates_presence_of :email, :message => "can't be blank"
  validates_presence_of :name, :message => "can't be blank"

  before_save :ensure_authentication_token

end
