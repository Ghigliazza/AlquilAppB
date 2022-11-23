class ApiController < ApplicationController

  def index

     #Redirecciona al usuario si es conductor
     if (current_user.driver?)
        redirect_to "/search"
     end
  
     # Guarda todos los autos en estado 1(disponible) y los ordena por combustible (luego sera por distancia)

     @carsList = Car.where(:state => :rented)

  end

end