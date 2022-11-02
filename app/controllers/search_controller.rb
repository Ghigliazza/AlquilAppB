class SearchController < ApplicationController

  def index
  
     # Guarda todos los autos en estado 1(disponible) y los ordena por combustible (luego sera por distancia)
     @carsDisponibles = Car.where(:state => 1).order(fuel: :desc)

  end



end
