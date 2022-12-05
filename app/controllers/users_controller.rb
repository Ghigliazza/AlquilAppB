class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  skip_before_action :require_login, only: [:index, :new, :create] # this should only be used if you are allowing users to register themselves. 

  # GET /users or /users.json
  def index
    if !current_user.driver?
      @users = User.all
      
    else
      redirect_to user_path(current_user), alert: "No tienes permisos para ver otros usuarios!"
    end
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  def suspended
    if !current_user.suspended_driver?
      redirect_to "/search"
    end
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        if current_user
          format.html { redirect_to request.referrer, notice: "Cuenta creada correctamente." }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { redirect_to '/login', notice: "Cuenta creada correctamente." }
          format.json { render :show, status: :created, location: @user }
        end
      else

        if @user.errors.any?
          @user.errors.each do |error|
            if error.full_message == "Password confirmation doesn't match Password"
              format.html { redirect_to request.referrer, alert: "Las contraseñas no coinciden" }
            end
            if error.full_message == "Email has already been taken"
              format.html { redirect_to request.referrer, alert: "E-mail ya existe en el sistema" }
            end
            if error.full_message == "Password is too short (minimum is 3 characters)"
              format.html { redirect_to request.referrer, alert: "La contraseña es muy corta (menor a 3 caracteres)" }
            end      
            if error.full_message == "Document has already been taken"  
              format.html { redirect_to request.referrer, alert: "El DNI ya existe en el sistema" }
            end  
            format.html { redirect_to request.referrer, alert: error.message }
          end
        end 
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|

      if (current_user.document.to_i != user_params[:document].to_i) && current_user.admin?

        # Verificamos que la password del admin sea la correcta
        if extra_params[:q_pass].to_s != "1234"
          format.html { redirect_to request.referrer, alert: "Contraseña incorrecta #{extra_params[:q_pass].to_s}" }
        else
            # Actualiza el usuario normalmente
            if @user.update(user_params)
              #format.html { redirect_to user_url(@user), notice: "Datos actualizados correctamente." }
              #format.html { redirect_to "#{user_url(@user)}/edit", notice: "Datos actualizados correctamente." }
              format.html { redirect_to request.referrer, notice: "Datos procesados correctamente." }
              format.json { render :edit, status: :ok, location: @user }
            else

              if @user.errors.any?
                @user.errors.each do |error|
                  if error.full_message == "Password confirmation doesn't match Password"
                    format.html { redirect_to request.referrer, alert: "Las contraseñas no coinciden" }
                  end
                  if error.full_message == "Email has already been taken"
                    format.html { redirect_to request.referrer, alert: "E-mail ya existe en el sistema" }
                  end
                  if error.full_message == "Password is too short (minimum is 3 characters)"
                    format.html { redirect_to request.referrer, alert: "La contraseña es muy corta (menor a 3 caracteres)" }
                  end      
                  if error.full_message == "Document has already been taken"  
                    format.html { redirect_to request.referrer, alert: "El DNI ya existe en el sistema" }
                  end  
                  format.html { redirect_to request.referrer, alert: error.message }
                end
              end 

              format.html { redirect_to request.referrer, notice: "Datos incorrectos." }
              format.json { render json: @user.errors, status: :unprocessable_entity }
            end          
        end  

      else

        if @user.update(user_params)
          #format.html { redirect_to user_url(@user), notice: "Datos actualizados correctamente." }
          #format.html { redirect_to "#{user_url(@user)}/edit", notice: "Datos actualizados correctamente." }
          format.html { redirect_to request.referrer, notice: "Datos procesados correctamente." }
          format.json { render :edit, status: :ok, location: @user }
        else

          if @user.errors.any?
            @user.errors.each do |error|
              if error.full_message == "Password confirmation doesn't match Password"
                format.html { redirect_to request.referrer, alert: "Las contraseñas no coinciden" }
              end
              if error.full_message == "Email has already been taken"
                format.html { redirect_to request.referrer, alert: "E-mail ya existe en el sistema" }
              end
              if error.full_message == "Password is too short (minimum is 3 characters)"
                format.html { redirect_to request.referrer, alert: "La contraseña es muy corta (menor a 3 caracteres)" }
              end      
              if error.full_message == "Document has already been taken"  
                format.html { redirect_to request.referrer, alert: "El DNI ya existe en el sistema" }
              end  
              format.html { redirect_to request.referrer, alert: error.message }
            end
          end 

          format.html { redirect_to request.referrer, notice: "Datos incorrectos." }
          #format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end

      end


    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to request.referrer, notice: "Eliminado correctamente." }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :rol, :name, :lastName, :document, :state, :license_url, :position_id, :coords_y, :coords_x, :licenseNumber, :licenseExpiration, :license_photo, :birthdate, :rejectedMessage, :suspended_for, :suspended_until)
    end

    # Parametros para confirmar password del admin
    def extra_params
      params.require(:user).permit(:q_pass)
    end
end
