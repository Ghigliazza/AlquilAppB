class User < ApplicationRecord
  authenticates_with_sorcery!
  
  #ASSOCIATIONS
  has_one :position
  has_many :card
  has_many :rental
  has_many :report
  has_many :cars, :through => :rental

  #VALIDATIONS
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true
  validates :document, uniqueness: true

  #ENUMERATIVES
  enum rol: [:administrator, :supervisor, :driver]
  enum state: [:for_admit, :addmiss, :dismiss, :blok]

  #SCOPES
  scope :administrators,   -> { where(:rol => :administrator)}
  scope :supervisors,      -> { where(:rol => :supervisor)}
  scope :drivers,          -> { where(:rol => :driver)}
  scope :for_admits,       -> { where(:state => :for_admit)}
  scope :admissed,         -> { where(:state => :admiss)}
  scope :dimissed,         -> { where(:state => :dimiss)}
  scope :bloked,           -> { where(:state => :blok)}
  scope :debtors,          -> { where("balance < 0")}
  scope :defaulter,        -> { self.debtors.bloked }
  scope :licenses_expired, -> { where("licenseExpiration < ?", Time.now)}
  scope :recent_rental?,   -> { self.rental.order('expires').first['expires'] < Time.now }
end
