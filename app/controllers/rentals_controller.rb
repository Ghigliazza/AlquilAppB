class RentalsController < ApplicationController
  before_action :set_rental,    only: %i[ show edit update destroy ]
  before_action :timeOut?,      only: %i[ update cancel ]
  before_action :requirements,  only: :create
 
# ================================================================================================================
  # GET /rentals or /rentals.json
  def index
    @rentals = Rental.all
  end

  # GET /rentals/1 or /rentals/1.json
  def show
    
  end

  # GET /rentals/new
  def new
    @rental = Rental.new()
  end

  # GET /rentals/1/edit
  def edit
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
    respond_to do |format|
      if @rental.update(rental_params)
        format.html { redirect_to rental_url(@rental), notice: "El alquiler ha sido extendido exitosamente." }
        format.json { render :show, status: :ok, location: @rental }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rental.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /rental/id
  def cancel
    set_rental()
    # Si no encendio el auto
    if !@rental.car.engine
      alert = ""
      notice = "El alquiler ha sido cancelado exitosamente"
      # Si no pasaron 10 minutos entonces cancela el alquiler (devuelve el precio del mismo)
      if Time.now < @rental.created_at + 10.minutes
        @rental.user.update_attribute :balance, @rental.user.balance + @rental.price
        notice += " y se le ha devuelto el costo del mismo, con un valor de: $#{@rental.price}"
      
      else  
        alert = "Lo sentimos, pero como ya encendio el motor no se le devolvera el costo del alquiler"
      end
      
      @rental.update_attribute :state, :expired
    else
      alert = "El motor debe estar apagado para cancelar el alquiler"
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
      @rent_time = (@rental.expires - Time.now).round
    end
  end

  # Only allow a list of trusted parameters through.
  def rental_params
    if request.method() == "POST"
      params.require(:rental).permit(:price, :expires, :user_id, :car_id)
    else
      params.require(:rental).permit(:price, :expires)
    end
  end


  def requirements
    alert = ''

    if params[:rental][:price].to_i > current_user.balance
      alert = "No tiene suficiente saldo"
    end

    last_rent = current_user.rentals.last
    # Si hay una renta, esta tiene el mismo auto que se quiere alquilar y pasaron 3 hs desde el ultimo alquiler
    if last_rent && last_rent.car == params[:car_id] && last_rent[:expires] > Time.now - 3.hours 
      alert = "no puede alquialr este auto antes de 3 hs de su ultimo alquiler"
    end

    if !current_user.admitted?
      alert = "debe estar habilitado para alquialr este auto"
    end

    if !alert.empty?
      redirect_to rentals_path, alert: alert
    end
  end


  def timeOut?
    set_rental()
    # si el alquiler expiro 0 termino el tiempo de alquiler
    if @rental.expired? || @rent_time <= 0
      if !@rental.expired?
        @rental.expired!
      end
      redirect_to rental_path, alert: "El alquiler ah expirado"
    end
  end

end