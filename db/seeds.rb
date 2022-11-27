# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


#==================================================##==================================================#
#																									CAR
#==================================================##==================================================#
=begin

Car.destroy_all;

brand = [ "Ford", "Fiat", "Chevrolet", "Nissan", "Peugeot", "Subaru", "Toyota", "Audi", "Honda" ];
model = {
	"Ford" 			=> [ "Fiesta", "Mustang" ],
 	"Fiat" 			=> [ "500" ],
	"Chevrolet" => [ "Aveo" ],
	"Nissan" 		=> [ "Ariya", "Evalia" ],
	"Peugeot" 	=> [ "208", "308" ],
	"Subaru" 		=> [ "Forester" ],
	"Toyota" 		=> [ "Auris", "Yaris" ],
	"Audi" 			=> [ "RS 5" ],
	"Honda" 		=> [ "Civic" ]
};
license = {
	"Fiesta" 		=> [ "AB111CD", "AB222CD" ],
	"Mustang"		=> [ "BB444CC" ],
	"500" 			=> [ "AB333CD" ],
	"Aveo"			=> [ "AB444CD" ],
	"Ariya" 		=> [ "AB333CD" ],
	"Evalia"		=> [ "AB666CD" ],
	"208" 			=> [ "AB777CD" ],
	"308"				=> [ "AB888CD" ],
	"Forester"	=> [ "AB999CD" ],
	"Auris" 		=> [ "AB000CD" ],
	"Yaris"     => [ "BB111CD" ],
	"RS 5" 			=> [ "BB111CC" ],
	"Civic" 		=> [ "BB222CD", "BB333CD"]
};
color = {
	"AB111CD" 	=> [ "Blanco" ],
	"AB222CD"		=> [ "Azul" ],
	"BB444CC" 	=> [ "Naranja" ],
	"AB333CD" 	=> [ "Azul ", "Plateado" ],
	"AB444CD" 	=> [ "Blanco" ],
	"AB666CD" 	=> [ "Negro" ],
	"AB777CD" 	=> [ "Celeste" ],
	"AB888CD" 	=> [ "Vede" ],
	"AB999CD" 	=> [ "Azul" ],
	"AB000CD" 	=> [ "Azul" ],
	"BB111CD" 	=> [ "Rojo" ],
	"BB111CC" 	=> [ "Verde" ],
	"BB222CD" 	=> [ "Rojo" ],
	"BB333CD" 	=> [ "Azul" ]
};

(1..10).each do |i|
	br = brand[rand(brand.count)];
	md = model[br][rand(model[br].count)];
	lic = license[md][rand(license[md].count)];
	col = color[lic][rand(color[lic].count)];

	Car.create(
		model: md,
		brand: br,
		license: lic,
		color: col,
		img_url:"/autos/#{lic}.jpg",
		doors: rand(2..5).round(),
		seats: rand(4..7).round(),
		state: rand(0..2).round(),
		engine: rand(0..1).round(),
		fuel: rand(0..40).round(2),
		transmission: rand(1).round() ? "Automatica" : "Manual",
		coords_x: rand(-57.97..-57.93).round(9),
		coords_y: rand(-34.95..-34.91).round(9)
	);
end


p "Seed created #{Car.count} cars";


#==================================================##==================================================#
#																									USER
#==================================================##==================================================#

User.destroy_all;

(1..10).each do |i|
	rol = i == 1 ? :admin : (i < 5 ? :supervisor : :driver);
	doc = rand(35000000..45000000).round();
	lic = "";
	(0..11).each do |j|
		n = rand(0..9);
		lic += n.to_s;
		if (j+1) % 4 == 0 && j < 11
			lic += "-";
		end
	end
	exp = Time.new(2022 + rand(0..1), rand(1..12), rand(1..31), rand(0..23), rand(0..60), rand(0..60));

	if rol == :driver
		ste = Time.now > exp ? :rejected : User.states.keys[rand(0..User.states.count)];
		
	else
		ste = :admitted;
	end
	
	ln = rol == :admin ? "" : User.where(rol: rol).count;

	User.create(
		email: "#{rol}#{ln}@gmail.com",
		password: 1234,
		password_confirmation: 1234,
		rol: rol,
		name: rol,
		lastName: ln,
		document: doc,
		state: ste,
		license_url: "",
		licenseNumber: lic,
		licenseExpiration: exp,
		balance: rand(0..10000).round(2),
		coords_x: rand(-57.97..-57.93).round(4),
		coords_y: rand(-34.95..-34.91).round(4)
	);
end

p "Seed created #{User.count} users"

#==================================================##==================================================#
#																						 		 RENTAL
#==================================================##==================================================#

Rental.destroy_all

(1..10).each do |i|
	hs = rand(0..23);
	exp = Time.new(2022 + rand(0..1), rand(1..12), rand(1..31), hs, rand(0..60), rand(0..60));
	ste = Time.now > exp ? :expired : Rental.states.keys[rand(0..Rental.states.count - 2)];
	Rental.create(
		price: (hs + 1) * 1000,
		expires: exp,
		user_id: rand(User.count),
		car_id: rand(Car.count),
		state: ste
	);
end

p "Seed created #{Rental.count} rentals";

=end

#==================================================##==================================================#
#							  				                     	SEED MANUAL
#==================================================##==================================================#

#==================================================##==================================================#
#																									USER
#==================================================##==================================================#

#Creo un par de usuarios manualmente para facilitar el testeo
User.destroy_all;
User.create!([
	{
	email: "super@gmail.com",                                                   
	password: 1234,
	password_confirmation: 1234,                                 
	rol: :supervisor,                                                       
	name: "Adriel",                                                 
	lastName: "Garcia",                                                
	document: 42345678,                                           
	state: :empty,                                                  
	license_url: "",    
	licenseNumber: nil,
	licenseExpiration: nil,
	birthdate: Date.today - 26.years,
	balance: 5000,
	coords_x: -57.957160476901834,
	coords_y: -34.919451958400096 
	},
	{
	email: "super2@gmail.com",                                                   
	password: 1234,
	password_confirmation: 1234,                                 
	rol: :supervisor,                                                       
	name: "Jose",                                                 
	lastName: "Luna",                                                
	document: 40055000,                                           
	state: :empty,                                                  
	license_url: "",    
	licenseNumber: nil,
	licenseExpiration: nil,
	birthdate: Date.today - 26.years,
	balance: 5000,
	coords_x: -57.957160476901834,
	coords_y: -34.919451958400096 
	},
	{
	email: "a@gmail.com",                                                   
	password: 1234,
	password_confirmation: 1234,                                 
	rol: :driver,                                                       
	name: "Juan",                                                 
	lastName: "Garcia",                                                
	document: 40849561,                                           
	state: :admitted,                                                  
	license_url: "",  
	licenseNumber: 99999999,
	licenseExpiration: Date.today + 6.month,
	birthdate: Date.today - 26.years,
	balance: 15000,
	coords_x: -57.957160476901834,
	coords_y: -34.919451958400096 
	},
	{
	email: "test@gmail.com",                                                   
	password: 1234,
	password_confirmation: 1234,                                 
	rol: :driver,                                                       
	name: "Julian",                                                 
	lastName: "Pazos",                                                
	document: 40841161,                                           
	state: :admitted,                                                  
	license_url: "",  
	licenseNumber: 99999999,
	licenseExpiration: Date.today + 6.month,
	birthdate: Date.today - 26.years,
	balance: 15000,
	coords_x: -57.957160476901834,
	coords_y: -34.919451958400096 
	},
	{
	email: "test2@gmail.com",                                                   
	password: 1234,
	password_confirmation: 1234,                                 
	rol: :driver,                                                       
	name: "Silvia",                                                 
	lastName: "Ortega",                                                
	document: 40842261,                                           
	state: :admitted,                                                  
	license_url: "",  
	licenseNumber: 99999999,
	licenseExpiration: Date.today + 6.month,
	birthdate: Date.today - 26.years,
	balance: 15000,
	coords_x: -57.957160476901834,
	coords_y: -34.919451958400096 
	},
	{
	email: "rich@gmail.com",                                                   
	password: 1234,
	password_confirmation: 1234,                                 
	rol: :driver,                                                       
	name: "Ricardo",                                                 
	lastName: "Garcia",                                                
	document: 40849590,                                           
	state: :admitted,                                                  
	license_url: "",  
	licenseNumber: 99999999,
	licenseExpiration: Date.today + 6.month,
	birthdate: Date.today - 26.years,
	balance: 200000,
	coords_x: -57.957160476901834,
	coords_y: -34.919451958400096 
	},
	{
	email: "rich2@gmail.com",                                                   
	password: 1234,
	password_confirmation: 1234,                                 
	rol: :driver,                                                       
	name: "Leonel",                                                 
	lastName: "Lopez",                                                
	document: 42849590,                                           
	state: :admitted,                                                  
	license_url: "",  
	licenseNumber: 99999999,
	licenseExpiration: Date.today + 6.month,
	birthdate: Date.today - 26.years,
	balance: 200000,
	coords_x: -57.957160476901834,
	coords_y: -34.919451958400096 
	},
	{
	email: "poor@gmail.com",                                                   
	password: 1234,
	password_confirmation: 1234,                                 
	rol: :driver,                                                       
	name: "Matias",                                                 
	lastName: "Garcia",                                                
	document: 40849510,                                           
	state: :admitted,                                                  
	license_url: "",  
	licenseNumber: 99999999,
	licenseExpiration: Date.today + 6.month,
	birthdate: Date.today - 26.years,
	balance: 20,
	coords_x: -57.957160476901834,
	coords_y: -34.919451958400096 
	},
	{
	email: "poor2@gmail.com",                                                   
	password: 1234,
	password_confirmation: 1234,                                 
	rol: :driver,                                                       
	name: "Tomás",                                                 
	lastName: "Campos",                                                
	document: 40849999,                                           
	state: :admitted,                                                  
	license_url: "",  
	licenseNumber: 99999999,
	licenseExpiration: Date.today + 6.month,
	birthdate: Date.today - 26.years,
	balance: 20,
	coords_x: -57.957160476901834,
	coords_y: -34.919451958400096 
	},
	{
	email: "admin@gmail.com",                                                   
	password: 1234,
	password_confirmation: 1234,                                 
	rol: :admin,                                                       
	name: "Admin",                                                 
	lastName: "Diaz",                                                
	document: 66,                                           
	state: :admitted,                                                  
	license_url: "",  
	licenseNumber: 99999999,
	licenseExpiration: Date.today + 6.month,
	birthdate: Date.today - 26.years,
	balance: 20,
	coords_x: -57.957160476901834,
	coords_y: -34.919451958400096 
	}
])

# Crea un usuario individual para saltear el 'validates' (licencia expirada)
u = User.new(
	email: "vencido@gmail.com", 
	crypted_password: "$2a$10$S8iA.kmjBnrO8VefLuDqbeNztExIc.HHmDISnYYHrF19m043BLUhS",  
	salt: "cLFho39dqLpgoSbTNxoT",                                                
	password: 1234,
	password_confirmation: 1234,                                 
	rol: :driver,                                                       
	name: "Alberto",                                                 
	lastName: "Gonzales",                                                
	document: 40849568,                                           
	state: :admitted,                                                  
	license_url: "",  
	licenseNumber: 99999999,
	licenseExpiration: Date.today - 6.month,
	birthdate: Date.today - 26.years,
	balance: 5000,
	coords_x: -57.957160476901834,
	coords_y: -34.919451958400096)
u.save(validate:false)

u = User.new(
	email: "vencido2@gmail.com", 
	crypted_password: "$2a$10$S8iA.kmjBnrO8VefLuDqbeNztExIc.HHmDISnYYHrF19m043BLUhS",  
	salt: "cLFho39dqLpgoSbTNxoT",                                                
	password: 1234,
	password_confirmation: 1234,                                 
	rol: :driver,                                                       
	name: "Rodolfo",                                                 
	lastName: "Gonzales",                                                
	document: 41122009,                                           
	state: :admitted,                                                  
	license_url: "",  
	licenseNumber: 99999999,
	licenseExpiration: Date.today - 6.month,
	birthdate: Date.today - 26.years,
	balance: 5000,
	coords_x: -57.957160476901834,
	coords_y: -34.919451958400096)
u.save(validate:false)

u = User.new(
	email: "free@gmail.com", 
	crypted_password: "$2a$10$S8iA.kmjBnrO8VefLuDqbeNztExIc.HHmDISnYYHrF19m043BLUhS",  
	salt: "cLFho39dqLpgoSbTNxoT",                                                
	password: 1234,
	password_confirmation: 1234,                                 
	rol: :suspended_driver,                                                       
	name: "Patricio",                                                 
	lastName: "Gonzales",                                                
	document: 43522009,                                           
	state: :admitted,                                                  
	license_url: "",  
	licenseNumber: 99999999,
	licenseExpiration: Date.today + 6.month,
	birthdate: Date.today - 26.years,
	suspended_until: Date.today - 6.month,
	suspended_for: "Romper las reglas",
	balance: 5000,
	coords_x: -57.957160476901834,
	coords_y: -34.919451958400096)
u.save(validate:false)


p "Seed created #{User.count} users"

#==================================================##==================================================#
#																									CAR
#==================================================##==================================================#

Car.destroy_all;
Car.create!([{
	model: "Fiesta",
	brand: "Ford",
	license:"AB111CD",
	color:"Blanco",
	img_url:"/autos/AB111CD.jpg",
	doors: 4,
	seats: 4,
	state: :ready,
	engine: 0,
	#position_id: ,
	fuel: 30,
	transmission: "Manual",
	description: "Esta es una descripcion del vehiculo. Aca se especifican detalles que no entran en la tabla, como por ejemplo, si tiene una abolladura.",
	coords_x: -57.942948097923505,
	coords_y: -34.90961858045628
	},
	{
	model: "500",
	brand: "Fiat",
	license:"AB333CD",
	color:"Azul",
	img_url:"/autos/AB333CD.jpg",
	doors: 2,
	seats: 4,
	state: :blocked,
	engine: 0,
	#position_id: ,
	fuel: 30,
	transmission: "Manual",
	description: "",
	coords_x: -57.95706724595495,
	coords_y: -34.90940742232333
	},
	{
	model: "Ariya",
	brand: "Nissan",
	license:"AB555CD",
	color:"Plateado",
	img_url:"/autos/AB555CD.jpg",
	doors: 4,
	seats: 5,
	state: :ready,
	engine: 0,
	#position_id: ,
	fuel: 20,
	transmission: "Manual",
	description: "",
	coords_x: -57.95835470642984,
	coords_y: -34.92598168391016 
	},
	{
	model: "RS 5",
	brand: "Audi",
	license:"BB111CC",
	color:"Verde",
	img_url:"/autos/BB111CC.jpg",
	doors: 4,
	seats: 5,
	state: :blocked,
	engine: 0,
	#position_id: ,
	fuel: 20,
	transmission: "Manual",
	description: "",
	coords_x: -57.95540514473136,
	coords_y: -34.89957991096459 
	}, 
])

p "Seed created #{Car.count} cars";


########################################### Autos y Usuarios con rental  ##############################################

User.create!([
	{
	id: 60,
	email: "renting@gmail.com",                                                   
	password: 1234,
	password_confirmation: 1234,                                 
	rol: :driver,                                                       
	name: "Franco",                                                 
	lastName: "Garcia",                                                
	document: 40841510,                                           
	state: :admitted,                                                  
	license_url: "",  
	licenseNumber: 99999999,
	licenseExpiration: Date.today + 6.month,
	birthdate: Date.today - 26.years,
	balance: 2000,
	coords_x: -57.957160476901834,
	coords_y: -34.919451958400096 
	},
	{
	id: 65,
	email: "expired@gmail.com",                                                   
	password: 1234,
	password_confirmation: 1234,                                 
	rol: :driver,                                                       
	name: "Francisco",                                                 
	lastName: "Pavón",                                                
	document: 40141510,                                           
	state: :admitted,                                                  
	license_url: "",  
	licenseNumber: 99999999,
	licenseExpiration: Date.today + 6.month,
	birthdate: Date.today - 26.years,
	balance: 2000,
	coords_x: -57.957160476901834,
	coords_y: -34.919451958400096 
	},
	{
	id: 70,
	email: "renting2@gmail.com",                                                   
	password: 1234,
	password_confirmation: 1234,                                 
	rol: :driver,                                                       
	name: "Ernesto",                                                 
	lastName: "Vicente",                                                
	document: 408992233,                                           
	state: :admitted,                                                  
	license_url: "",  
	licenseNumber: 99999999,
	licenseExpiration: Date.today + 6.month,
	birthdate: Date.today - 26.years,
	balance: 2000,
	coords_x: -57.957160476901834,
	coords_y: -34.919451958400096 
	},
	{
	id: 75,
	email: "expired2@gmail.com",                                                   
	password: 1234,
	password_confirmation: 1234,                                 
	rol: :driver,                                                       
	name: "Sol",                                                 
	lastName: "Neira",                                                
	document: 408772233,                                           
	state: :admitted,                                                  
	license_url: "",  
	licenseNumber: 99999999,
	licenseExpiration: Date.today + 6.month,
	birthdate: Date.today - 26.years,
	balance: 2000,
	coords_x: -57.957160476901834,
	coords_y: -34.919451958400096 
	},
])

Car.create!([
	{
	id: 60,
	model: "Aveo",
	brand: "Chevrolet",
	license:"AB444CD",
	color:"Blanco",
	img_url:"/autos/AB444CD.jpg",
	doors: 4,
	seats: 4,
	state: :rented,
	engine: 0,
	#position_id: ,
	fuel: 23,
	transmission: "Manual",
	description: "",
	coords_x: -57.96440576970384,
	coords_y: -34.913947202499656
	},
	{
	id: 65,
	model: "308",
	brand: "Peugeot",
	license:"AB888CD",
	color:"Blanco",
	img_url:"/autos/AB888CD.jpg",
	doors: 4,
	seats: 4,
	state: :rented,
	engine: 0,
	#position_id: ,
	fuel: 3,
	transmission: "Manual",
	description: "",
	coords_x: -57.94944155306433,
	coords_y: -34.94550968612329 
	},
	{
	id: 70,
	model: "208",
	brand: "Peugeot",
	license:"AB777CD",
	color:"Celeste",
	img_url:"/autos/AB777CD.jpg",
	doors: 4,
	seats: 5,
	state: :rented,
	engine: 1,
	turn_on: 1,
	#position_id: ,
	fuel: 5,
	transmission: "Manual",
	description: "",
	coords_x: -57.943218828135564,
	coords_y: -34.9340761736041 
	},
	{
	id: 75,
	model: "Civic",
	brand: "Honda",
	license:"BB222CD",
	color:"Rojo",
	img_url:"/autos/BB222CD.jpg",
	doors: 2,
	seats: 2,
	state: :rented,
	engine: 0,
	turn_on: 1,
	#position_id: ,
	fuel: 21.8,
	transmission: "Manual",
	description: "",
	coords_x: -57.9604648102025,
	coords_y: -34.923821996733736 
	},
])

Rental.destroy_all
Rental.create!([
	{
	price: 5000,
	expires: Time.now + 3.hours,
	user_id: 60,
	car_id: 60,
	state: :started,
	created_at: Time.now - 2.hours,
	total_hours: 5,
	initial_fuel: 30
	},
	{
	price: 6000,
	expires: Time.now + 4.hours,
	user_id: 70,
	car_id: 70,
	state: :started,
	created_at: Time.now - 2.hours,
	total_hours: 6,
	initial_fuel: 30
	},
	{
	price: 3000,
	expires: Time.now - 1.hours,
	user_id: 65,
	car_id: 65,
	state: :started,
	created_at: Time.now - 5.hours,
	total_hours: 3,
	initial_fuel: 30
	},
	{
	price: 9000,
	expires: Time.now - 3.hours,
	user_id: 75,
	car_id: 75,
	state: :started,
	created_at: Time.now - 12.hours,
	total_hours: 9,
	initial_fuel: 30
	},
])

p "Seed created #{Rental.count} rentals (with cars & users)";

Report.destroy_all
