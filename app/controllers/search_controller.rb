class SearchController < ApplicationController

  def index

     #Verifica el estado de expiracion de la licencia y suspension
     verificar_licencia
     verificar_suspension

     #Redirecciona al usuario si tiene un alquiler activo
     if (current_user.driver? && current_user.rentals.any? && !current_user.rentals.last.expired?)
        redirect_to "/rentals/#{current_user.rentals.last.id}", notice: "Alquiler activo..."
     else
        if current_user.new_supervisor?
          redirect_to "/supervisors/new_password", notice: "Debes cambiar tu contraseña para continuar..."
        else
          if current_user.suspended_driver?
            redirect_to "/users/suspended"
          end
        end
     end
    
  
     # Guarda todos los autos en estado 1(disponible) y los ordena por combustible (luego sera por distancia)
     @carsDisponibles = Car.where(:state => 0).order(fuel: :desc)

     
     #No es eficiente (arreglar)
     actualizarDistancias #Actualiza la distancia respecto al usuario actual
     
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

  # Verifica el estado de la licencia de conducir, y bloquea al usuario si está vencida
  def verificar_licencia
    if (current_user.driver? || current_user.suspended_driver?) && current_user.admitted?
      if current_user.licenseExpiration.present? && current_user.licenseExpiration < Date.today

        #Pasar al usuario al estado :expired (pone la licencia en nil para que no impida hacer un update el 'validates')
        current_user.update(state: 'expired', licenseExpiration: nil);

      end
    end
  end

  def verificar_suspension
    if current_user.suspended_driver?
      if current_user.suspended_until.present? && current_user.suspended_until < Date.today
        current_user.update(rol: 'driver', suspended_until: nil);
      end
    end
  end


end