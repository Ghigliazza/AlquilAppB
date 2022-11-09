class Car < ApplicationRecord
	#ASSOCIATIONS
	has_one :position
	has_many :rental
	has_many :report
	has_many :users, :through => :rental

	#ENUMERATIVES
	enum state: [:ready, :rented, :blok]

	#scopes
	scope :readys, 		-> 			 { where(:state => :ready)}
	scope :renteds, 	-> 			 { where(:state => :rented)}
	scope :bloked, 		-> 			 { where(:state => :blok)}
	scope :low_fuel, 	-> 			 { where("fuel < 1")}
	scope :models, 		->(model){ where(model: model) }
	scope :brands, 		->(brand){ where(brand: brand) }
	scope :colors, 		->(color){ where(color: color) }
	scope :doors, 		->(doors){ where(doors: doors) }
	scope :seats, 		->(seats){ where(seats: seats) }
end
