class ApplicationController < ActionController::Base
  before_action :require_login
  before_action :require_rent_finish


  private
  def not_authenticated
    redirect_to login_path, alert: "Please login first"
  end

  # verifica si hay una alquiler activo, si lo hay bloque al usuario en la pantalla de alquiler y si tiene mas de 1 alquiler los bloquea
  def require_rent_finish
    # if current_user
    #   str_rentals = current_user.rentals.started
      
    #   # if str_rentals.first
    #   #   str_rentals.first.update(state: :started)
    #   # end
      
    #   puts '11111<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<'
    #     if str_rentals.count == 1
    #       act_rent = str_rentals.first

    #       puts '22222222222<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<'
    #       act_rent_path = rentals_path + "/" + act_rent.id.to_s

    #       #Si hay una renta activa y si se intenta salir de la renta actual
    #       if act_rent.started? && !(request.fullpath() == act_rent_path && request.method() == "GET")
    #         puts '333333333333<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<'
    #         redirect_to rental_path, alert: "No Puede Realizar Otra Accion Hasta Terminado Su alquiler"
    #       end

    #     elsif str_rentals.count > 1
    #       puts 'fallo<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<'
    #       str_rentals.update_all(state: :bloked)
    #       redirect_to root_path, alert: "No puede tener mas de un alquiler activo, por lo que todos ellos fueron bloqueados"
    #   end 
    # end
  end
end