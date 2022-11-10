class SearchController < ApplicationController


  def index
  
     # Guarda todos los autos en estado 1(disponible) y los ordena por combustible (luego sera por distancia)

     #Actualiza la distancia respecto al usuario actual
     #No es eficiente (arreglar)
     actualizarDistancias
     
     if current_user.driver?
      @carsDisponibles = Car.where(:state => :ready).order(:distance).order(fuel: :desc)
     else
      @carsDisponibles = Car.all.order(:distance).order(fuel: :asc)
     end

     
     
  end

  def actualizarDistancias
    @dist = 0
    Car.where(:state => 0).each do |c| 
      if (session[:lng] && session[:lat])
        @dist = distancia(c.coords_x,c.coords_y,session[:lng],session[:lat])
        c.update(distance: @dist)   
      else
        c.update(distance: 999999999) 
      end  
    end 
  end



  def distancia (car_x,car_y,user_x,user_y)

    @total = 999

    # Si no se tiene la posicion del user actual, la distancia es 0
    #if (session[:lat] && session[:lng])

    if (user_x != nil && user_y != nil)

      @distx = (car_x - user_x).magnitude * 111000
      @disty = (car_y - user_y).magnitude * 111000

      @total = (@distx * @distx) + (@disty * @disty)
      @total = Math.sqrt(@total)

      @total = @total
        
    end
    

    return @total
  end
  helper_method :distancia



end
