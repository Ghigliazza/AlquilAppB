class ApplicationController < ActionController::Base
  before_action :require_login

  private
  def not_authenticated
    redirect_to login_path, notice: "Debes iniciar sesión para utilizar la aplicación"
  end
  
end

