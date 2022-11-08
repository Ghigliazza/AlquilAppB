class Rental < ApplicationRecord
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
  enum state: { started: STARTED_PRICE, extended: EXTENDED_PRICE, expired: EXPIRED_PRICE }

  #SCOPES
  scope :licenses_expired, -> { where("licenseExpiration < ?", Time.now) }

  #METHODS
  def calcule_date(date1, date2)
    return new DateTime(date1.year + date2.year, date1.month + date2.month, date1.day + date2.day, date1.hour + date2.hour + date1.second + date2.second, )
  end


  def requirements()
    if @rental.price > current_user.balance && Date.now
      
    else
 
    end
  end
end