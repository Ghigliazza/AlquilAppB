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

     @string = params[:q].split(' ')

     if @string[1] == nil
        @supervisorList = User.where("name LIKE ?", "%" + params[:q] + "%").where(:rol => :supervisor)
        @supervisorList = @supervisorList + User.where("lastName LIKE ?", "%" + params[:q] + "%").where(:rol => :supervisor)
        @supervisorList = @supervisorList + User.where("email LIKE ?", "%" + params[:q] + "%").where(:rol => :supervisor)
        @supervisorList = @supervisorList + User.where("document LIKE ?", "%" + params[:q] + "%").where(:rol => :supervisor)

        @supervisorList = @supervisorList + User.where("name LIKE ?", "%" + params[:q] + "%").where(:rol => :new_supervisor)
        @supervisorList = @supervisorList + User.where("lastName LIKE ?", "%" + params[:q] + "%").where(:rol => :new_supervisor)
        @supervisorList = @supervisorList + User.where("email LIKE ?", "%" + params[:q] + "%").where(:rol => :new_supervisor)
        @supervisorList = @supervisorList + User.where("document LIKE ?", "%" + params[:q] + "%").where(:rol => :new_supervisor)
      else
        @supervisorList = User.where("name LIKE ?", "%" + @string[0] + "%").where("lastName LIKE ?", "%" + @string[1] + "%").where(:rol => :supervisor)
        @supervisorList = @supervisorList + User.where("name LIKE ?", "%" + @string[0] + "%").where("lastName LIKE ?", "%" + @string[1] + "%").where(:rol => :new_supervisor)
      end
     
     @supervisorList = @supervisorList.uniq

  end

  def delete

    aux_id = params[:q_id].to_i

    if !(current_user.valid_password?(params[:q_pass]))
      redirect_to request.referrer, alert: "La contrase??a del administrador es incorrecta."
    else
      User.where(id: aux_id).destroy_all
      redirect_to request.referrer, notice: "Supervisor eliminado correctamente."            
    end    

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