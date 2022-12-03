class User < ApplicationRecord
  authenticates_with_sorcery!
  
  #ASSOCIATIONS
  has_one :position
  has_many :cards
  has_many :rentals
  has_many :reports
  has_many :fines
  has_many :cars, :through => :rental

  has_one_attached :license_photo

  #VALIDATIONS
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true
  validates :document, uniqueness: true

  validates :email, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "La dirección de email debe tener un formato válido (nombre@ejemplo.com)" }

  validates :birthdate, presence: true
  validate :validate_age
  validate :validate_age_old

  validate :validate_expiration
  validate :validate_suspension_date


  

  #ENUMERATIVES
  enum rol: [:admin, :supervisor, :driver, :new_supervisor, :suspended_driver]
  enum state: [:empty, :submitted, :admitted, :rejected, :blocked, :expired]
  
  # empty: cuenta recien creada/ no hay datos subidos
  # submitted: subio o actualizo los datos para manejar
  # admitted: datos verificados y aceptados. Puede manejar.
  # rejected: datos verificados y rechazados
  # blocked: usuario bloqueado por supervisor/admin

  #SCOPES
  scope :administrators,   -> { where(:rol => :admin)}
  scope :supervisors,      -> { where(:rol => :supervisor)}
  scope :drivers,          -> { where(:rol => :driver)}
  scope :submitted,        -> { where(:state => :submitted)}
  scope :admitted,         -> { where(:state => :admitted)}
  scope :rejected,         -> { where(:state => :rejected)}
  scope :blocked,          -> { where(:state => :blocked)}
  scope :debtors,          -> { where("balance < 0")}
  scope :defaulter,        -> { self.debtors.blocked }
  scope :licenses_expired, -> { where("licenseExpiration < ?", Time.now)}
  scope :recent_rental?,   -> { self.rental.order('expires').first['expires'] < Time.now }


  private 
  def validate_age
      if birthdate.present? && birthdate > 18.years.ago.to_date
          errors.add(:birthdate, 'Debes ser mayor de 18 años para utilizar esta aplicación')
      end
  end
  def validate_age_old
      if birthdate.present? && birthdate < 150.years.ago.to_date
          errors.add(:birthdate, 'Fecha de nacimiento invalida (mayor a 150 años)')
      end
  end
  def validate_expiration
      if licenseExpiration.present? && licenseExpiration < Date.today
          errors.add(:birthdate, 'La licencia está expirada')
      end
  end
  def validate_suspension_date
      if suspended_until.present? && suspended_until < Date.today
          errors.add(:suspension_date, 'La fecha de suspensión ya pasó')
      end
  end

end
