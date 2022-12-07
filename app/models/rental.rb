class Rental < ApplicationRecord
  #ASSOCIATIONS
  belongs_to :user
  belongs_to :car
  has_many :payments, dependent: :destroy

  #VALIDATIONS
  validates :user_id, uniqueness: false
  validates :car_id, uniqueness: false

  #CONSTANTS
  STARTED_PRICE = 1000
  EXTENDED_PRICE = 1750
  EXPIRED_PRICE = 4000

  MIN_DURATION = 1
  MAX_DURATION = 24

  #ENUMERATIVES
  enum state: { started: STARTED_PRICE, extended: EXTENDED_PRICE, expired: EXPIRED_PRICE, bloked: -1}

  #SCOPES
  # scope :expired, -> { where("expires < ?", Time.now) }

  #METHODS
  def tenMinutesPassed?
    return self.created_at + 10.minutes <= Time.now
  end

  def turnedOn?
    return self.turned_on
  end
end
