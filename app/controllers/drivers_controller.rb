class DriversController < ApplicationController

  def index

  	 if !current_user.admin? && !current_user.supervisor?
  	 	redirect_to "/search", alert: "No tienes permiso para ver esta pagina!"
  	 end
     
     @driverList = User.where(:rol => :driver)

  end

  def search

  	 if !current_user.admin? && !current_user.supervisor?
  	 	redirect_to "/search", alert: "No tienes permiso para ver esta pagina!"
  	 end

     @driverList = User.where("name LIKE ?", "%" + params[:q] + "%").where(:rol => :driver)
     @driverList = @driverList + User.where("lastName LIKE ?", "%" + params[:q] + "%").where(:rol => :driver)
     @driverList = @driverList + User.where("email LIKE ?", "%" + params[:q] + "%").where(:rol => :driver)
     @driverList = @driverList + User.where("document LIKE ?", "%" + params[:q].to_s + "%").where(:rol => :driver)
     
     @driverList = @driverList.uniq

  end


end