class DriversController < ApplicationController

  def index

  	 if !current_user.admin? && !current_user.supervisor?
  	 	redirect_to "/search", alert: "No tienes permiso para ver esta pagina!"
  	 end
     
     @driverList = User.where(:rol => :driver) + User.where(:rol => :suspended_driver)

     if current_user.admin?
         if params[:sort_param] == "descendente"
            @driverList.sort! { |a,b| -a.balance <=> -b.balance }
         else
            @driverList.sort! { |a,b| a.balance <=> b.balance }
         end
     end

  end

  def search

  	 if !current_user.admin? && !current_user.supervisor?
  	 	redirect_to "/search", alert: "No tienes permiso para ver esta pagina!"
  	 end

     @string = params[:q].split(' ')

     if @string[1] == nil
        @driverList = User.where("name LIKE ?", "%" + params[:q] + "%").where(:rol => :driver)
        @driverList = @driverList + User.where("lastName LIKE ?", "%" + params[:q] + "%").where(:rol => :driver)
        @driverList = @driverList + User.where("email LIKE ?", "%" + params[:q] + "%").where(:rol => :driver)
        @driverList = @driverList + User.where("document LIKE ?", "%" + params[:q].to_s + "%").where(:rol => :driver)

        @driverList = @driverList + User.where("name LIKE ?", "%" + params[:q] + "%").where(:rol => :suspended_driver)
        @driverList = @driverList + User.where("lastName LIKE ?", "%" + params[:q] + "%").where(:rol => :suspended_driver)
        @driverList = @driverList + User.where("email LIKE ?", "%" + params[:q] + "%").where(:rol => :suspended_driver)
        @driverList = @driverList + User.where("document LIKE ?", "%" + params[:q].to_s + "%").where(:rol => :suspended_driver)
     else
        @driverList = User.where("name LIKE ?", "%" + @string[0] + "%").where("lastName LIKE ?", "%" + @string[1] + "%").where(:rol => :driver)
        @driverList = @driverList + User.where("name LIKE ?", "%" + @string[0] + "%").where("lastName LIKE ?", "%" + @string[1] + "%").where(:rol => :suspended_driver)
     end
     
     @driverList = @driverList.uniq

     if current_user.admin?
         if params[:sort_param] == "descendente"
            @driverList.sort! { |a,b| -a.balance <=> -b.balance }
         else
            @driverList.sort! { |a,b| a.balance <=> b.balance }
         end
     end

  end


end