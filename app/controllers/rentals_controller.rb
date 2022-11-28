class RentalsController < ApplicationController
  before_action :set_rental, only: %i[ show edit update destroy cancel ]
  after_action  :summary,    only: %i[ create show update cancel ]
 
# ================================================================================================================
  # GET /rentals or /rentals.json
  def index
    @rentals = Rental.all
  end
# ----------------------------------------------------------------------------------------------------------------------------------------
  # GET /rentals/1 or /rentals/1.json
  def show

    # DESACTIVADO PARA LA DEMO
    # Si se pasa el tiempo de expiracion, no se finalizo aun y el motor esta apagado, se finaliza AUTOMATICAMENTE
    if ((Time.now > @rental.expires) && (!@rental.expired?) && (!@rental.car.engine?))
      # Actualiza el estado del alquiler
      @rental.expired!

      time_out()

      # Cobra el gasto de combustible y actualiza el combustible inicial
      if @rental.car.fuel < @rental.initial_fuel
        current_user.update(balance: current_user.balance - (@rental.car.fuel - @rental.initial_fuel) * 150)
      end
      @rental.update(initial_fuel: @rental.car.fuel)

      # Actualiza el auto de la renta
      @rental.car.ready!
      @rental.car.update(turn_on: false)
      
      redirect_to "/rentals/#{@rental.id}", alert:"El alquiler ha sido finalizado fuera de tiempo. Precio: $#{@rental.price}. (Además se cobró una multa de $1000 por cada 15 minutos pasados: $#{multa} total de multa.)"
    end
  end

# ----------------------------------------------------------------------------------------------------------------------------------------
  # GET /rentals/new
  def new
    @rental = Rental.new()

    # Si el usuario no esta habilitado para manejar
    if (!current_user.admitted?)
      redirect_to request.referrer, alert: "Tu cuenta debe estar habilitada para alquilar un auto."
      
    # Si el saldo es 0 o Si no hay suficiente saldo
    elsif ((current_user.balance == 0) || (current_user.balance / Rental.states[:started]) < 1)
        redirect_to request.referrer, alert: "No tienes suficeinte saldo para realizar un alquiler (Saldo actual: $#{current_user.balance}, Minimo necesario: $#{Rental.states[:started]})"
        
      # Si el usuario alquilo el mismo auto hace menos de 3 horas (No solo chequea el ultimo alquiler, sino los anteriores tambien)
    elsif (current_user.rentals.any? && (current_user.rentals.where(car_id: params[:car_id].to_i).any?) && (current_user.rentals.where(car_id: params[:car_id].to_i).last.updated_at < Time.now + 3.hours))
        redirect_to request.referrer, alert: "Debes esperar al menos 3 horas antes de alquilar el mismo auto."
    end
  end

# ----------------------------------------------------------------------------------------------------------------------------------------
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

  # ----------------------------------------------------------------------------------------------------------------------------------------
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

# ----------------------------------------------------------------------------------------------------------------------------------------
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

  
# ----------------------------------------------------------------------------------------------------------------------------------------
  # GET /rental/id
  def cancel
    # Setea un valor inicial del Alert (vacio)
    alert = ''

    # Si el motor está apagado
    if !@rental.car.engine
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
          time_out()
          alert = "El alquiler ha sido finalizado fuera de tiempo. Precio: $#{@rental.price}. (Además se cobró una multa de $1000 por cada 15 minutos pasados: $#{penalty} total de multa.)"
        
        else
          # Si pasaron 10 minutos entonces simplemente se finaliza, sin devolver el dinero
          notice = "El alquiler ha sido finalizado correctamente. Precio final: $#{@rental.price}"
        end
      end

      @rental.car.ready!
      @rental.car.update(turn_on:false)
      @rental.expired!

    else
      alert = "Debe apagar el motor antes de finalizar el alquiler"
    end

    if alert.empty?
      redirect_to rental_path, notice: notice   
    else
      redirect_to rental_path, notice: notice, alert: alert
    end
  end
  
# ----------------------------------------------------------------------------------------------------------------------------------------
  # DELETE /rentals/1 or /rentals/1.json
  def destroy
    @rental.destroy
    respond_to do |format|
      format.html { redirect_to rentals_url, notice: "El alquiler ha sido eliminado exitosamente." }
      format.json { head :no_content }
    end
  end

# ----------------------------------------------------------------------------------------------------------------------------------------
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_rental
    @rental = Rental.find(params[:id])
    if @rental
      @time_left = (@rental.expires - Time.now)
      @rent_time = ((@rental.expires - @rental.created_at)/1.hour).round
    end
  end

# ----------------------------------------------------------------------------------------------------------------------------------------
  # Only allow a list of trusted parameters through.
  def rental_params
    if request.method() == "POST"
      params.require(:rental).permit(:price, :expires, :user_id, :car_id, :initial_fuel, :state, :total_hours)
    else
      params.require(:rental).permit(:price, :expires, :initial_fuel, :state, :total_hours)
    end
  end


# ----------------------------------------------------------------------------------------------------------------------------------------
  # Calcular y descontar multa
  def time_out()
    time_dif = ((Time.now - @rental.expires) / 15.minutes).to_i
    penalty = 1000 * time_dif
    current_user.update(balance: (current_user.balance - penalty))
  end
  
# ----------------------------------------------------------------------------------------------------------------------------------------
  def summary()
    # Si 'summary' esta vacio le instancia la cabecera (solo para antes del metodo 'create')
    summary = params[:action] != 'create' ? @rental.summary :
      "<div class=\"card card-body\">
        <ol class=\"list-group list-group-numbered\">"

    #Se agregan los valores del pago actual
    if params[:action] == 'create' || params[:action] == 'update'
      # Genera un id unico para cada collapse a partir de la fecha de actualizacion
      id = rand(@rental.updated_at.to_i)
      summary +=
          "<li class=\"list-group-item d-flex justify-content-between align-items-start\">
            <div class=\"ms-4 me-auto\">
              <div class=\"fw-bold\"> Pago del #{ @rental.updated_at.strftime('%Y-%m-%e A las %k:%M:%S') } </div>
              <p>
                <a class=\"btn btn-outline-success\" data-bs-toggle=\"collapse\" href=\"#collapsePay_#{ id }\" role=\"button\" aria-expanded=\"false\" aria-controls=\"collapsePay_#{ id }\">
                  Detalle de pago
                </a>
              </p>
                
              <div class=\"collapse\" id=\"collapsePay_#{ id }\">
                <ul>
                  <li class=\"row\"><div class=\"col-auto fw-semibold\"> Precio:     </div> <div class=\"col fw-light fst-italic text-end\"> #{ params[:rental][:price].to_f }                             </div></li>
                  <li class=\"row\"><div class=\"col-auto fw-semibold\"> Alquilado:  </div> <div class=\"col fw-light fst-italic text-end\"> #{ ((@rental.expires - @rental.created_at)/1.hours).round }hs </div></li>
                  <li class=\"row\"><div class=\"col-auto fw-semibold\"> Inicio:     </div> <div class=\"col fw-light fst-italic text-end\"> #{ @rental.updated_at.strftime('%Y-%m-%e A las %k:%M:%S') }   </div></li>
                  <li class=\"row\"><div class=\"col-auto fw-semibold\"> Expiracion: </div> <div class=\"col fw-light fst-italic text-end\"> #{ @rental.expires.strftime('%Y-%m-%e A las %k:%M:%S') }      </div></li>
                </ul>
              </div>
            </div>
          </li>"

    # Se agrega el footer cuando expira el alquiler (el ultimo argumento es para que no se agregue el footer cada vez que se quiera ver el alquiler)
    elsif @rental.expired? && @rental.updated_at + 1.second > Time.now 
      summary +=
        "</ol>
      </div>
      <div class=\"card-footer ms-4 me-auto\">
        <strong> Resumen de alquiler </strong>
        <ul>
          <li class=\"row\"><div class=\"col-auto fw-semibold\"> Horas Totales:  </div> <div class=\"col fw-light fst-italic text-end\"> #{ @rental.total_hours }hs                                                                     </div></li>
          <li class=\"row\"><div class=\"col-auto fw-semibold\"> Precio Total:   </div> <div class=\"col fw-light fst-italic text-end\"> #{ @rental.totalPrice ? @rental.totalPrice : @rental.price }                                   </div></li>
          <li class=\"row\"><div class=\"col-auto fw-semibold\"> Cancelado:      </div> <div class=\"col fw-light fst-italic text-end\"> #{ params[:action] == 'cancel' ? Time.now.strftime('%Y-%m-%e A las %k:%M:%S') : "- - - -" }    </div></li>
          <li class=\"row\"><div class=\"col-auto fw-semibold\"> Saldo Devuelto: </div> <div class=\"col fw-light fst-italic text-end\"> #{ params[:action] == 'cancel' ? @rental.totalPrice ? @rental.totalPrice : @rental.price : 0 } </div></li>
        </ul>
      </div>"
    end
  
    @rental.update(summary: summary)
  end
end