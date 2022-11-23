class RentalsController < ApplicationController
  before_action :set_rental,    only: %i[ show edit update destroy cancel timeOut? turnedOn? ]
  #before_action :requirements,  only: :create
 
# ================================================================================================================
  # GET /rentals or /rentals.json
  def index
    @rentals = Rental.all
  end

  # GET /rentals/1 or /rentals/1.json
  def show

    # DESACTIVADO PARA LA DEMO
    ## Si se pasa el tiempo de expiracion, el motor esta apagado y no se finalizo aun, se finaliza AUTOMATICAMENTE
    #if ((Time.now > @rental.expires) && (!@rental.expired?) && (!@rental.car.engine?))
    #    @rental.expired!
    #    # Descontar Multa
    #    diferencia_t = ((Time.now - @rental.expires) / 15.minutes).to_i
    #    multa = 1000 * diferencia_t
    #    current_user.update(balance: (current_user.balance - multa))

    #    @rental.car.ready!
    #    Car.find(@rental.car_id).update(turn_on:false)
    #    redirect_to "/rentals/#{current_user.rentals.last.id}", alert:"El alquiler ha sido finalizado fuera de tiempo. Precio: $#{@rental.price}. (Además se cobró una multa de $1000 por cada 15 minutos pasados: $#{multa} total de multa.)"
    #end
  end

  # GET /rentals/new
  def new
    @rental = Rental.new()

    # Si el usuario no esta habilitado para manejar
    if (! current_user.admitted?)
      redirect_to request.referrer, alert: "Tu cuenta debe estar habilitada para alquilar un auto."
      
    # Si el saldo es 0 o Si no hay suficiente saldo
    elsif ((current_user.balance == 0) || (current_user.balance / Rental.states[:started]) < 1)
        redirect_to request.referrer, alert: "No tienes suficeinte saldo para realizar un alquiler (Saldo actual: $#{current_user.balance}, Minimo necesario: $#{Rental.states[:started]})"
        
      # Si el usuario alquilo el mismo auto hace menos de 3 horas (No solo chequea el ultimo alquiler, sino los anteriores tambien)
    elsif (current_user.rentals.any? && (current_user.rentals.where(car_id: params[:car_id].to_i).any?) && (current_user.rentals.where(car_id: params[:car_id].to_i).last.updated_at < Time.now + 3.hours))
        redirect_to request.referrer, alert: "Debes esperar al menos 3 horas antes de alquilar el mismo auto."
    end
  end

  # GET /rentals/1/edit
  def edit

    # Si se alcanza la cantidad de horas maxima
    if @rental.total_hours == 24
      redirect_to request.referrer, alert: "No puedes alquilar un auto por mas de 24 horas."
      # Si el saldo es 0 o Si no hay suficiente saldo

    elsif ((current_user.balance == 0) || (current_user.balance / Rental.states[:extended]) < 1)
      redirect_to request.referrer, alert: "No tienes suficiente saldo para extender el alquiler (Saldo actual: $#{current_user.balance}, Minimo necesario: $#{Rental.states[:extended]})"
      
      # Si el alquiler caduco
    elsif (Time.now > @rental.expires)
      redirect_to request.referrer, alert: "No puedes extender el alquiler si ya está vencido."
    end
  end

  # POST /rentals or /rentals.json
  def create
    @rental = Rental.new(rental_params)

    respond_to do |format|
      if @rental.save
        # Actualiza el balance del usuario
        current_user.update(balance: current_user.balance - @rental.price)
        # Actializa el estado del auto
        Car.find(@rental.car_id).rented!

        format.html { redirect_to rental_url(@rental), notice: "Auto alquilado correctamente" }
        format.json { render :show, status: :created, location: @rental }
      else
        format.html { render :new, status: :unprocessable_entity, notice: :alert }
        format.json { render json: @rental.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rentals/1 or /rentals/1.json
  def update
    if Time.now < @rental.expires && !@rental.expired?
      # Actualiza el balance del usuario
      current_user.update_attribute :balance, current_user.balance - params[:rental][:price].to_i
      #Actualiza el Valor total de la renta
      params[:rental][:price] = params[:rental][:price].to_i + @rental.price
  
      respond_to do |format|
        if @rental.update(rental_params)
          format.html { redirect_to rental_url(@rental), notice: "El alquiler ha sido extendido exitosamente." }
          format.json { render :show, status: :ok, location: @rental }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @rental.errors, status: :unprocessable_entity }
        end
      end
      
    else
      redirect_to rental_path, alert: "No puedes extender el alquiler si ya está vencido."
    end
  end

  # GET /rental/id
  def cancel

    # Setea un valor inicial del Alert (vacio)
    alert = ''

    # Si el motor está apagado
    if !@rental.car.engine
      Car.find(@rental.car_id).ready!
      # Si no pasaron 10 minutos entonces cancela el alquiler (devuelve el precio del mismo)
      if Time.now < @rental.created_at + 10.minutes

        if @rental.car.turn_on?
          notice = "El alquiler ha sido finalizado correctamente. Precio final: $#{@rental.price}. (El motor fue encendido, por lo que no se devolverá el costo del alquiler)"
        else
          @rental.user.update_attribute :balance, @rental.user.balance + @rental.price
          notice = "El alquiler ha sido cancelado, y se le ha devuelto el costo del mismo, con un valor de: $#{@rental.price}"         
        end


      elsif (Time.now >= @rental.created_at + 10.minutes)
        # Si expiro
        if (Time.now > @rental.expires)
          # Calcular y descontar multa
          time_dif = ((Time.now - @rental.expires) / 15.minutes).to_i
          penalty = 1000 * time_dif
          current_user.update(balance: (current_user.balance - penalty))
  
          alert = "El alquiler ha sido finalizado fuera de tiempo. Precio: $#{@rental.price}. (Además se cobró una multa de $1000 por cada 15 minutos pasados: $#{penalty} total de multa.)"
        
        else
          # Si pasaron 10 minutos entonces simplemente se finaliza, sin devolver el dinero
          notice = "El alquiler ha sido finalizado correctamente. Precio final: $#{@rental.price}"
        end
      end   

      Car.find(@rental.car_id).update(turn_on:false)
      @rental.update_attribute :state, :expired

    else
      alert = "Debe apagar el motor antes de finalizar el alquiler"
    end

    if alert.empty?
      redirect_to rental_path, notice: notice   
    else
      redirect_to rental_path, notice: notice, alert: alert
    end
  end
  
  # DELETE /rentals/1 or /rentals/1.json
  def destroy
    @rental.destroy
    respond_to do |format|
      format.html { redirect_to rentals_url, notice: "El alquiler ha sido eliminado exitosamente." }
      format.json { head :no_content }
    end
  end

# ================================================================================================================
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_rental
    @rental = Rental.find(params[:id])
    if @rental
      @time_left = (@rental.expires - Time.now)
      @rent_time = ((@rental.expires - @rental.created_at)/1.hour).round
    end
  end

  # Only allow a list of trusted parameters through.
  def rental_params
    if request.method() == "POST"
      params.require(:rental).permit(:price, :expires, :user_id, :car_id, :initial_fuel, :summary, :state, :total_hours)
    else
      params.require(:rental).permit(:price, :expires, :initial_fuel, :summary, :state, :total_hours)
    end
  end


#  CHEQUEOS CAMBIADOS DE LUGAR
#
#  def requirements
#    alert = ''
#
#    if params[:rental][:price].to_i > current_user.balance
#      alert = "No tiene suficiente saldo"
#    end
#
#    last_rent = current_user.rentals.last
#    # Si hay una renta, esta tiene el mismo auto que se quiere alquilar y pasaron 3 hs desde el ultimo alquiler
#    if last_rent && last_rent.car == params[:car_id] && last_rent[:expires] > Time.now - 3.hours 
#      alert = "No puede alquilar este auto a menos de 3 hs desde su ultimo alquiler"
#    end
#
#    if !current_user.admitted?
#      alert = "Debe estar habilitado para alquilar un auto"
#    end
#
#    if !alert.empty?
#      redirect_to "/rentals/#{current_user.rentals.last.id}", alert: alert
#    end
#  end


end