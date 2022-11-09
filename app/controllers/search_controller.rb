class SearchController < ApplicationController


  def index
  
     # Guarda todos los autos en estado 1(disponible) y los ordena por combustible (luego sera por distancia)
     @carsDisponibles = Car.where(:state => 1).order(fuel: :desc)
     
  end



  def distance (car_x,car_y,user_x,user_y)

    @distx = (car_x - user_x).magnitude * 111000
    @disty = (car_y - user_y).magnitude * 111000

    @total = (@distx * @distx) + (@disty * @disty)
    @total = Math.sqrt(@total)

    # Pasar a metros?
    @total = @total

    return @total

  end
  helper_method :distance



end
