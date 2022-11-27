class SupervisorsController < ApplicationController

  def index

  	 if !current_user.admin?
  	 	redirect_to "/search", alert: "No tienes permiso para ver esta pagina!"
  	 end
     
     @supervisorList = User.where(:rol => :supervisor)
   
  end


end