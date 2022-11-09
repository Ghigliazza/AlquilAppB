class SearchController < ApplicationController


  def index
  
     # Guarda todos los autos en estado 1(disponible) y los ordena por combustible (luego sera por distancia)
     #@carsDisponibles = Car.where(:state => 1).order(fuel: :desc)

     #Actualiza la distancia respecto al usuario actual
     #No es eficiente (arreglar)
     actualizarDistancias

     @carsDisponibles = Car.where(:state => 1).order(:distance)
     
  end

  def actualizarDistancias
    @dist = 0
    Car.where(:state => 1).each do |c| 
      
      @dist = distancia(c.coords_x,c.coords_y,session[:lng],session[:lat])

      c.update(distance: @dist)      
    end 
  end



  def distancia (car_x,car_y,user_x,user_y)
    @distx = (car_x - user_x).magnitude * 111000
    @disty = (car_y - user_y).magnitude * 111000

    @total = (@distx * @distx) + (@disty * @disty)
    @total = Math.sqrt(@total)

    # Pasar a metros?
    @total = @total

    return @total
  end
  helper_method :distancia



end
