class ApplicationController < ActionController::Base
  before_action :require_login
  before_action :require_rent_finish


  private
  def not_authenticated
    redirect_to login_path, alert: "Please login first"
  end

  def require_rent_finish
    if current_user
      str_rentals = current_user.rentals.started
        if str_rentals.count == 1
          act_rent = str_rentals.first
          if act_rent.started? && page
            
          end
          
        else
              
      end 
    end
  end
    
end

