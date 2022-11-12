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
	r = ["admin", "supervisor", "driver"];
	rol = i == 1 ? r[0] : r[rand(1..User.rols.count - 1)];
	doc = rand(35000000..45000000).round();
	lic = "";
	(0..11).each do |j|
		n = rand(0..9);
		if j < 7
			doc += n*10**j;
		end

		lic += n.to_s;
		if (j+1) % 4 == 0 && j < 11
			lic += "-";
		end
	end
	exp = Time.new(2022, rand(1..10), rand(1..31), rand(0..23), rand(0..60), rand(0..60));

	User.create(
		email: "#{rol}#{i != 1 ? i : ''}@gmail.com",
		password: 1234,
		password_confirmation: 1234,
		rol: rol,
		name: "#{rol}#{i != 1 ? i : ''}",
		lastName: "",
		document: doc,
		state: Time.now > exp ? User.states[:rejected] : User.states[rand(User.states.count)],
		license_url: "",
		licenseNumber: lic,
		licenseExpiration: exp,
		balance: rand(0..10000).round(2),
		coords_x: rand(-57.97..-57.93).round(4),
		coords_y: rand(-34.95..-34.91).round(4)
	);
end

#Creo un par de usuarios manualmente para facilitar el testeo
User.create!([
	{
	email: "super",                                                   
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
	balance: 5000,
	coords_x: -57.957160476901834,
	coords_y: -34.919451958400096 
	},

	{
	email: "a",                                                   
	password: 1234,
	password_confirmation: 1234,                                 
	rol: :driver,                                                       
	name: "Juan",                                                 
	lastName: "Garcia",                                                
	document: 42345679,                                           
	state: :admitted,                                                  
	license_url: "",  
	licenseNumber: nil,
	licenseExpiration: nil,
	balance: 5000,
	coords_x: -57.957160476901834,
	coords_y: -34.919451958400096 

	},
])

p "Seed created #{User.count} users"

#==================================================##==================================================#
#																						 		 RENTAL
#==================================================##==================================================#

Rental.destroy_all

(1..10).each do |i|
	hs = rand(0..23);
	expire = Time.new(2022, rand(1..12), rand(1..31), hs, rand(0..60), rand(0..60));
	Rental.create(
		price: (hs + 1) * 1000,
		expires: expire,
		user_id: rand(User.count),
		car_id: rand(Car.count),
		state: Rental.states[rand(0..2)]
	);
end

p "Seed created #{Rental.count} rentals";