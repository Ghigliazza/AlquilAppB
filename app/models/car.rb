class Car < ApplicationRecord
	#ASSOCIATIONS
	has_one :position
	has_many :rentals
	has_many :reports
	has_many :users, :through => :rental
	has_one_attached :car_photo

	#ENUMERATIVES
	enum state: [:ready, :rented, :blocked]

	#scopes
	scope :readys, 		-> 			 { where(:state => :ready)}
	scope :renteds, 	-> 			 { where(:state => :rented)}
	scope :blocked, 	-> 		     { where(:state => :blocked)}
	scope :low_fuel, 	-> 			 { where("fuel < 1")}
	scope :models, 		->(model){ where(model: model) }
	scope :brands, 		->(brand){ where(brand: brand) }
	scope :colors, 		->(color){ where(color: color) }
	scope :doors, 		->(doors){ where(doors: doors) }
	scope :seats, 		->(seats){ where(seats: seats) }

	validate :validate_doors
	validate :validate_license
	validate :validate_seats

	def validate_doors
      if !(doors > 0) || (doors > 6)
          errors.add(:amount, 'Numero de puertas invalido')
      end
    end

    def validate_license
      if (Car.where(license:license).any?)
          errors.add(:amount, 'La patente ya existe en el sistema')
      end
    end

    def validate_seats
      if !(seats > 0) || (seats > 10)
          errors.add(:amount, 'Numero de asientos invalido')
      end
    end

end
