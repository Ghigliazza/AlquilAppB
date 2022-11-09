class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_back_or_to(:users, notice: 'Sesion iniciada correctamente')
    else
      flash.now[:alert] = 'Los datos son incorrectos'
      render action: 'new', status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to(:users, notice: 'Sesion cerrada!')
  end
end
