class Card < ApplicationRecord
	belongs_to :user

	# VALIDATIONS
	validates :number, length: { is: 12 }, on: :create, presence: :true

	# SCOPES
  scope :expired, -> { where("expires < ?", Time.now)}
end
