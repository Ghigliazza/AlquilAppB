class Card < ApplicationRecord
	belongs_to :user

	#SCOPES
  scope :expired, -> { where("expires < ?", Time.now)}
end
