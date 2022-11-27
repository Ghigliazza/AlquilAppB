class SupervisorsController < ApplicationController

  def index

  	 if !current_user.admin?
  	 	redirect_to "/search", alert: "No tienes permiso para ver esta pagina!"
  	 end
  	 @new_dni = new_document
  	 @new_number = supervisor_number
     
     @supervisorList = User.where(:rol => :supervisor) + User.where(:rol => :new_supervisor)

  end

  def new_password

  	@user = current_user
  	if !current_user.new_supervisor?
  		redirect_to "/search/"
  	end

  end

  def search

     if !current_user.admin?
      redirect_to "/search", alert: "No tienes permiso para ver esta pagina!"
     end
     @new_dni = new_document
     @new_number = supervisor_number

     @supervisorList = User.where("name LIKE ?", "%" + params[:q] + "%").where(:rol => :supervisor)
     @supervisorList = @supervisorList + User.where("lastName LIKE ?", "%" + params[:q] + "%").where(:rol => :supervisor)
     @supervisorList = @supervisorList + User.where("email LIKE ?", "%" + params[:q] + "%").where(:rol => :supervisor)

     @supervisorList = @supervisorList + User.where("name LIKE ?", "%" + params[:q] + "%").where(:rol => :new_supervisor)
     @supervisorList = @supervisorList + User.where("lastName LIKE ?", "%" + params[:q] + "%").where(:rol => :new_supervisor)
     @supervisorList = @supervisorList + User.where("email LIKE ?", "%" + params[:q] + "%").where(:rol => :new_supervisor)
     
     @supervisorList = @supervisorList.uniq

  end




   	
  # Devuelve un numero de documento que no existe en el sistema
  def new_document
  	found = false
  	number = 0
  	while (!found)
  		if User.where(document: number).any?
  			number = number + 1
  		else
  			found = true
  			return number
  		end
  	end

  	return -1
  end
  #helper_method :new_document

  def supervisor_number
  	if User.where(name:"Nuevo Supervisor").any?
  		number = 1
  		while (true)
  			if User.where(name:"Nuevo Supervisor", lastName: "##{number}").any?
  				number = number + 1
  			else
  				return number
  			end
  		end 		
  		#return (User.where(name:"Nuevo Supervisor").count + 1)
  	else
  		return 1
  	end
  end


end