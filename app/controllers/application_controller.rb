class ApplicationController < ActionController::Base
  before_action :require_login
  before_action :require_rent_finish


  private
  def not_authenticated
    redirect_to login_path, alert: "Please login first"
  end

  def require_rent_finish
    # if current_user
    #   str_rentals = current_user.rentals.started
    #     if str_rentals.count == 1
    #       act_rent = str_rentals.first
    #       #Si hay una renta activas y si se intenta salir de la renta actual
    #       if act_rent.started? && (request.fullpath().split('/')[1] == rentals_path.split('/')[1] && request.method() == "GET")
    #         redirect_to rental_path, alert: "No Puede Realizar Otra Accion Hasta Terminado Su alquiler"
    #       end

    #     else
    #       str_rentals.update_all(state: :expired)
    #       redirect_to root_path, alert: "No puede Tener Mas de Una Renta Activa"
    #   end 
    # end
  end
    
end

