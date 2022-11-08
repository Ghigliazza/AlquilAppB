class Rental < ApplicationRecord
  #RELATIONS
  belongs_to :user
  belongs_to :car

  #CONSTANTS
  STARTED_PRICE = 1000
  EXTENDED_PRICE = 1750
  EXPIRED_PRICE = 4000

  MIN_DURATION = 1
  MAX_DURATION = 24

  #ENUMERATIVES
  enum state: { started: STARTED_PRICE, extended: EXTENDED_PRICE, expired: EXPIRED_PRICE }

  #SCOPES
  scope :licenses_expired, -> { where("licenseExpiration < ?", Time.now) }
end