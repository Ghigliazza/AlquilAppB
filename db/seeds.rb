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
	img_url:"#{Rails.root}/app/assets/images/autos/AB111CD.jpg",
	doors: 4,
	seats: 4,
	state: 1,
	engine: 0,
	#position_id: ,
	fuel: 30,
	transmission: "Manual",
	description: "Esta es una descripcion del vehiculo. Aca se especifican detalles que no entran en la tabla, como por ejemplo, si tiene una abolladura."
	},
	{
	model: "Fiesta",
	brand: "Ford",
	license:"AB222CD",
	color:"Azul",
	img_url:"#{Rails.root}/app/assets/images/autos/AB222CD.jpg",
	doors: 4,
	seats: 4,
	state: 1,
	engine: 0,
	#position_id: ,
	fuel: 15,
	transmission: "Manual",
	description: ""
	},
	{
	model: "500",
	brand: "Fiat",
	license:"AB333CD",
	color:"Azul",
	img_url:"#{Rails.root}/app/assets/images/autos/AB333CD.jpg",
	doors: 2,
	seats: 4,
	state: 1,
	engine: 0,
	#position_id: ,
	fuel: 30,
	transmission: "Manual",
	description: ""
	},
	{
	model: "Aveo",
	brand: "Chevrolet",
	license:"AB444CD",
	color:"Blanco",
	img_url:"#{Rails.root}/app/assets/images/autos/AB444CD.jpg",
	doors: 4,
	seats: 4,
	state: 1,
	engine: 0,
	#position_id: ,
	fuel: 23,
	transmission: "Manual",
	description: ""
	},
	{
	model: "Ariya",
	brand: "Nissan",
	license:"AB555CD",
	color:"Plateado",
	img_url:"#{Rails.root}/app/assets/images/autos/AB555CD.jpg",
	doors: 4,
	seats: 5,
	state: 1,
	engine: 0,
	#position_id: ,
	fuel: 20,
	transmission: "Manual",
	description: ""
	},
	{
	model: "Evalia",
	brand: "Nissan",
	license:"AB666CD",
	color:"Negro",
	img_url:"#{Rails.root}/app/assets/images/autos/AB666CD.jpg",
	doors: 4,
	seats: 7,
	state: 1,
	engine: 0,
	#position_id: ,
	fuel: 23,
	transmission: "Manual",
	description: ""
	},
	{
	model: "208",
	brand: "Peugeot",
	license:"AB777CD",
	color:"Celeste",
	img_url:"#{Rails.root}/app/assets/images/autos/AB777CD.jpg",
	doors: 4,
	seats: 5,
	state: 0,
	engine: 0,
	#position_id: ,
	fuel: 5,
	transmission: "Manual",
	description: ""
	},
	{
	model: "308",
	brand: "Peugeot",
	license:"AB888CD",
	color:"Verde",
	img_url:"#{Rails.root}/app/assets/images/autos/AB888CD.jpg",
	doors: 4,
	seats: 4,
	state: 1,
	engine: 0,
	#position_id: ,
	fuel: 3,
	transmission: "Manual",
	description: ""
	},
	{
	model: "Forester",
	brand: "Subaru",
	license:"AB999CD",
	color:"Azul",
	img_url:"#{Rails.root}/app/assets/images/autos/AB999CD.jpg",
	doors: 4,
	seats: 5,
	state: 1,
	engine: 0,
	#position_id: ,
	fuel: 29.8,
	transmission: "Manual",
	description: ""
	},




	{
	model: "Auris",
	brand: "Toyota",
	license:"AB000CD",
	color:"Azul",
	img_url:"#{Rails.root}/app/assets/images/autos/AB000CD.jpg",
	doors: 4,
	seats: 5,
	state: 1,
	engine: 0,
	#position_id: ,
	fuel: 19.5,
	transmission: "Manual",
	description: ""
	},
	{
	model: "Yaris",
	brand: "Toyota",
	license:"BB111CD",
	color:"Rojo",
	img_url:"#{Rails.root}/app/assets/images/autos/BB111CD.jpg",
	doors: 4,
	seats: 5,
	state: 1,
	engine: 0,
	#position_id: ,
	fuel: 29.8,
	transmission: "Manual",
	description: ""
	},

	{
	model: "Mustang",
	brand: "Ford",
	license:"BB444CC",
	color:"Naranja",
	img_url:"#{Rails.root}/app/assets/images/autos/BB444CC.jpg",
	doors: 2,
	seats: 2,
	state: 1,
	engine: 0,
	#position_id: ,
	fuel: 39.8,
	transmission: "Manual",
	description: ""
	},
	{
	model: "RS 5",
	brand: "Audi",
	license:"BB111CC",
	color:"Verde",
	img_url:"#{Rails.root}/app/assets/images/autos/BB111CC.jpg",
	doors: 2,
	seats: 2,
	state: 1,
	engine: 0,
	#position_id: ,
	fuel: 29.8,
	transmission: "Manual",
	description: ""
	},
	{
	model: "Civic",
	brand: "Honda",
	license:"BB222CD",
	color:"Rojo",
	img_url:"#{Rails.root}/app/assets/images/autos/BB222CD.jpg",
	doors: 2,
	seats: 2,
	state: 1,
	engine: 0,
	#position_id: ,
	fuel: 21.8,
	transmission: "Manual",
	description: ""
	},
	{
	model: "Civic",
	brand: "Honda",
	license:"BB333CD",
	color:"Azul",
	img_url:"#{Rails.root}/app/assets/images/autos/BB333CD.jpg",
	doors: 2,
	seats: 2,
	state: 1,
	engine: 0,
	#position_id: ,
	fuel: 9.1,
	transmission: "Manual",
	description: ""
	}

])

p "Seed created #{Car.count} cars"