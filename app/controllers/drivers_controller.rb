class DriversController < ApplicationController

  def index

    calculate_total_balance

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

  #Calcula el total de balance positivo y negativo en el sistema
  def calculate_total_balance
   @total_positive = 0
   @total_negative = 0

   if User.where(:rol => :driver).any?
      User.where(:rol => :driver).each do |u| 
         if u.balance > 0
            @total_positive = @total_positive + u.balance
         else
            @total_negative = @total_negative - u.balance
         end
      end
   end
   if User.where(:rol => :suspended_driver).any?
      User.where(:rol => :suspended_driver).each do |u| 
         if u.balance > 0
            @total_positive = @total_positive + u.balance
         else
            @total_negative = @total_negative - u.balance
         end
      end 
   end
  end
  helper_method :calculate_total_balance


end