	
# Necesario para guardar y actualizar la localizacion del usuario
  # app/controllers/locations_controller.rb
 
class LocationsController < ApplicationController

  def create
    previous_lat = session[:lat]
 
    session[:lat] = params[:lat].to_f
    session[:lng] = params[:lng].to_f
 
    # Redirecciona y re-envia el mensaje de bienvenida
    if previous_lat.nil? && session[:lat].present?
      redirect_back fallback_location: root_path, notice: "Hola #{current_user.name}!"
    end
  end
end