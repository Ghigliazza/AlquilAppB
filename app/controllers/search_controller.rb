class SearchController < ApplicationController


  def index
  
     # Guarda todos los autos en estado 1(disponible) y los ordena por combustible (luego sera por distancia)

     #Actualiza la distancia respecto al usuario actual
     #No es eficiente (arreglar)
     actualizarDistancias
     
     if current_user.driver?
      @carsList = Car.where(:state => :ready).order(:distance)
     else
      @carsList = Car.all.order(:distance).order(fuel: :asc)
     end

     
     
  end

  def actualizarDistancias
    @dist = 0
    Car.all.each do |c| 
      if (current_user.coords_x && current_user.coords_y)
        @dist = distancia(c.coords_x,c.coords_y,current_user.coords_x,current_user.coords_y)
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