class Rental < ApplicationRecord
  #VALIDATIONS
  validates :user_id, uniqueness: false
  validates :car_id, uniqueness: false

  #ASSOCIATIONS
  belongs_to :user
  belongs_to :car

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
end
