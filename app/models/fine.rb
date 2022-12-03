class Fine < ApplicationRecord
	belongs_to :user

	validate :validate_positive

	def validate_positive
      if !(amount > 0)
          errors.add(:amount, 'El monto debe tener un valor mayor a cero.')
      end
    end

end
