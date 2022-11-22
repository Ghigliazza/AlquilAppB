class Car < ApplicationRecord
	#ASSOCIATIONS
	has_one :position
	has_many :rentals
	has_many :reports
	has_many :users, :through => :rental

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
end
