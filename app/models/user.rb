class User

  include Mongoid::Document

  has_many :reviews

  devise :token_authenticatable, :rememberable, :recoverable, :trackable

  field :email, :type => String
  field :score, :type => Integer, :default => 0
  field :name, :type => String
  field :authentication_token,  :type => String

  field :current_sign_in_at,    :type => DateTime
  field :last_sign_in_at,       :type => DateTime
  field :current_sign_in_ip,    :type => String
  field :last_sign_in_ip,       :type => String
  field :sign_in_count,         :type => Integer
  field :remember_created_at,   :type => DateTime

  field :reset_password_token,  :type => String
  field :reset_password_sent_at,:type => DateTime

  validates :name, :email, :presence => true
  validates :email, :uniqueness => { :case_sensitive => true }

  before_save :ensure_authentication_token
  before_save :set_score

  def set_score
    self.score = self.reviews.count
  end

  def set_score!
    set_score and save!
  end

  def gds_user?
     if self.email.match(/@digital.cabinet-office.gov.uk/)
       return true
     else
       return false
     end
  end

end
