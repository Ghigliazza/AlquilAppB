class Card < ApplicationRecord
	belongs_to :user

	# VALIDATIONS
	validates :number, presence: :true, uniqueness: true
	

	# ENUMERATIVES
	enum bankName: [ :Frances, :Galicia, :Naranja, :Provincia, :Visa, :Otro ]

	# SCOPES
  scope :expired, -> { where("expires < ?", Time.now)}
end
