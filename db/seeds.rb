# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


Car.destroy_all

Car.create!([{
	model: "Fiesta",
	brand: "Ford",
	license:"AB111CD",
	color:"Blanco",
	img_url:"/autos/AB111CD.jpg",
	doors: 4,
	seats: 4,
	state: 1,
	engine: 0,
	#position_id: ,
	fuel: 30,
	transmission: "Manual",
	description: "Esta es una descripcion del vehiculo. Aca se especifican detalles que no entran en la tabla, como por ejemplo, si tiene una abolladura.",
	coords_x: -57.942948097923505,
	coords_y: -34.90961858045628
	},
	{
	model: "Fiesta",
	brand: "Ford",
	license:"AB222CD",
	color:"Azul",
	img_url:"/autos/AB222CD.jpg",
	doors: 4,
	seats: 4,
	state: 1,
	engine: 0,
	#position_id: ,
	fuel: 15,
	transmission: "Manual",
	description: "",
	coords_x: -57.94775461640229,
	coords_y: -34.911096672180804
	},
	{
	model: "500",
	brand: "Fiat",
	license:"AB333CD",
	color:"Azul",
	img_url:"/autos/AB333CD.jpg",
	doors: 2,
	seats: 4,
	state: 1,
	engine: 0,
	#position_id: ,
	fuel: 30,
	transmission: "Manual",
	description: "",
	coords_x: -57.95706724595495,
	coords_y: -34.90940742232333
	},
	{
	model: "Aveo",
	brand: "Chevrolet",
	license:"AB444CD",
	color:"Blanco",
	img_url:"/autos/AB444CD.jpg",
	doors: 4,
	seats: 4,
	state: 1,
	engine: 0,
	#position_id: ,
	fuel: 23,
	transmission: "Manual",
	description: "",
	coords_x: -57.96440576970384,
	coords_y: -34.913947202499656
	},
	{
	model: "Ariya",
	brand: "Nissan",
	license:"AB555CD",
	color:"Plateado",
	img_url:"/autos/AB555CD.jpg",
	doors: 4,
	seats: 5,
	state: 0,
	engine: 0,
	#position_id: ,
	fuel: 20,
	transmission: "Manual",
	description: "",
	coords_x: -57.95835470642984,
	coords_y: -34.92598168391016 
	},
	{
	model: "Evalia",
	brand: "Nissan",
	license:"AB666CD",
	color:"Negro",
	img_url:"/autos/AB666CD.jpg",
	doors: 4,
	seats: 7,
	state: 0,
	engine: 0,
	#position_id: ,
	fuel: 23,
	transmission: "Manual",
	description: "",
	coords_x: -57.96492075410844,
	coords_y: -34.93312412341212
	},
	{
	model: "208",
	brand: "Peugeot",
	license:"AB777CD",
	color:"Celeste",
	img_url:"/autos/AB777CD.jpg",
	doors: 4,
	seats: 5,
	state: 0,
	engine: 0,
	#position_id: ,
	fuel: 5,
	transmission: "Manual",
	description: "",
	coords_x: -57.943218828135564,
	coords_y: -34.9340761736041 
	},
	{
	model: "308",
	brand: "Peugeot",
	license:"AB888CD",
	color:"Blanco",
	img_url:"/autos/AB888CD.jpg",
	doors: 4,
	seats: 4,
	state: 0,
	engine: 0,
	#position_id: ,
	fuel: 3,
	transmission: "Manual",
	description: "",
	coords_x: -57.94944155306433,
	coords_y: -34.94550968612329 
	},
	{
	model: "Forester",
	brand: "Subaru",
	license:"AB999CD",
	color:"Azul",
	img_url:"/autos/AB999CD.jpg",
	doors: 4,
	seats: 5,
	state: 0,
	engine: 0,
	#position_id: ,
	fuel: 29.8,
	transmission: "Manual",
	description: "",
	coords_x: -57.96302557666058,
	coords_y: -34.897135267221365 
	},
	{
	model: "Auris",
	brand: "Toyota",
	license:"AB000CD",
	color:"Azul",
	img_url:"/autos/AB000CD.jpg",
	doors: 4,
	seats: 5,
	state: 0,
	engine: 0,
	#position_id: ,
	fuel: 19.5,
	transmission: "Manual",
	description: "",
	coords_x: -57.94714689914605,
	coords_y: -34.935809119158755 
	},
	{
	model: "Yaris",
	brand: "Toyota",
	license:"BB111CD",
	color:"Rojo",
	img_url:"/autos/BB111CD.jpg",
	doors: 4,
	seats: 5,
	state: 0,
	engine: 0,
	#position_id: ,
	fuel: 29.8,
	transmission: "Manual",
	description: "",
	coords_x: -57.97392607395346,
	coords_y: -34.92032768971162 
	},

	{
	model: "Mustang",
	brand: "Ford",
	license:"BB444CC",
	color:"Naranja",
	img_url:"/autos/BB444CC.jpg",
	doors: 2,
	seats: 2,
	state: 0,
	engine: 0,
	#position_id: ,
	fuel: 39.8,
	transmission: "Manual",
	description: "",
	coords_x: -57.97332525928319,
	coords_y: -34.910896660170415 
	},
	{
	model: "RS 5",
	brand: "Audi",
	license:"BB111CC",
	color:"Verde",
	img_url:"/autos/BB111CC.jpg",
	doors: 2,
	seats: 2,
	state: 0,
	engine: 0,
	#position_id: ,
	fuel: 29.8,
	transmission: "Manual",
	description: "",
	coords_x: -57.96221897487571,
	coords_y: -34.92161398981082 
	},
	{
	model: "Civic",
	brand: "Honda",
	license:"BB222CD",
	color:"Rojo",
	img_url:"/autos/BB222CD.jpg",
	doors: 2,
	seats: 2,
	state: 0,
	engine: 0,
	#position_id: ,
	fuel: 21.8,
	transmission: "Manual",
	description: "",
	coords_x: -57.9604648102025,
	coords_y: -34.923821996733736 
	},
	{
	model: "Civic",
	brand: "Honda",
	license:"BB333CD",
	color:"Azul",
	img_url:"/autos/BB333CD.jpg",
	doors: 2,
	seats: 2,
	state: 0,
	engine: 0,
	#position_id: ,
	fuel: 9.1,
	transmission: "Manual",
	description: "",
	coords_x: -57.972638885076265,
	coords_y: -34.916433776031056 
	}

])

p "Seed created #{Car.count} cars"


# -------------------------------

User.destroy_all

User.create!([
	{
	email: "test@gmail.com",                                                   
	password: 1234,
	password_confirmation: 1234,                                 
	rol: 2,                                                       
	name: "Juan",                                                 
	lastName: "Garcia",                                                
	document: 42345678,                                           
	state: 0,                                                  
	license_url: "",    
	licenseNumber: nil,
	licenseExpiration: nil,
	balance: 5000
	},

	{
	email: "a",                                                   
	password: 1234,
	password_confirmation: 1234,                                 
	rol: 2,                                                       
	name: "Juan",                                                 
	lastName: "Garcia",                                                
	document: 42345679,                                           
	state: 1,                                                  
	license_url: "",  
	licenseNumber: nil,
	licenseExpiration: nil,
	balance: 5000,
	coords_x: -57.957160476901834,
	coords_y: -34.919451958400096 

	},


	{
	email: "test2@gmail.com",                                                   
	password: 1234,
	password_confirmation: 1234,                                 
	rol: 1,                                                       
	name: "Jose",                                                 
	lastName: "Gutierrez",                                                
	document: 38830194,                                           
	state: 0,                                                  
	license_url: "",   
	licenseNumber: nil,
	licenseExpiration: nil,
	balance: 1000
	},
	{
	email: "c@gmail.com",                                                   
	password: 1234,
	password_confirmation: 1234,                                                       
	rol: 1,                                                       
	name: "Aurelia",                                                 
	lastName: "Alamo",                                                
	document: 06705167,                                           
	state: 0,                                                  
	license_url: "",  
	licenseNumber: nil,
	licenseExpiration: nil,
	balance: 130000
	},
	{
	email: "d@gmail.com",                                                   
	password: 1234,
	password_confirmation: 1234,                                 
	rol: 1,                                                       
	name: "Esperanza",                                                 
	lastName: "Gómez",                                                
	document: 63543583,                                           
	state: 0,                                                  
	license_url: "",    
	licenseNumber: nil,
	licenseExpiration: nil,
	balance: 3000
	},
	{
	email: "e@gmail.com",                                                   
	password: 1234,
	password_confirmation: 1234,                                 
	rol: 1,                                                       
	name: "Alex",                                                 
	lastName: "Narvaez",                                                
	document: 37513057,                                           
	state: 0,                                                  
	license_url: "",   
	licenseNumber: nil,
	licenseExpiration: nil,
	balance: -6000
	},
	{
	email: "admin@gmail.com",                                                   
	password: 1234,
	password_confirmation: 1234,                                 
	rol: 0,                                                       
	name: "Admin",                                                 
	lastName: "Sito",                                                
	document: 'nan',                                           
	state: 0,                                                  
	license_url: "",   
	licenseNumber: nil,
	licenseExpiration: nil,
	balance: 999999999999999999999999999999999
	} 


])


Rental.destroy_all

# (1..10).each do
# 	n = rand(24).to_i,
# 	Rental.create(
# 		price: n*1000,
# 		expire: Time.now + n,
# 		user_id: rand(User.count).to_i,
# 		car_id: rand(Car.count).to_i
# 	)
	
# end


p "Seed created #{User.count} users"

p "Seed destroyed #{Rental.count} rentals"

