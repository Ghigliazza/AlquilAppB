class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :car

  #SCOPES
  scope :licenses_expired, -> { where("licenseExpiration < ?", Time.now)}
end
