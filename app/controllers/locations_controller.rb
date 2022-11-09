	
# Necesario para guardar y actualizar la localizacion del usuario
  # app/controllers/locations_controller.rb
 
class LocationsController < ApplicationController

  def create
    previous_lat = session[:lat]
 
    session[:lat] = params[:lat].to_f
    session[:lng] = params[:lng].to_f
 
    if previous_lat.nil? && session[:lat].present?
      redirect_back fallback_location: root_path
    end
  end
end