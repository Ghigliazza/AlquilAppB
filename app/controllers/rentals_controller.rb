class RentalsController < ApplicationController
  before_action :set_rental, only: %i[ show edit update destroy ]
  before_action :requirements, only: [:create]

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
    @rental_expired = Time.now + 1.hour
  end

  # GET /rentals/1/edit
  def edit
  end

  # POST /rentals or /rentals.json
  def create
    @rental = Rental.new(rental_params)

    respond_to do |format|
      if @rental.save
        Car.find(@rental.car_id).rented! #actializa el estado del auto

        format.html { redirect_to rental_url(@rental), notice: "Rental was successfully created." }
        format.json { render :show, status: :created, location: @rental }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rental.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rentals/1 or /rentals/1.json
  def update
    respond_to do |format|
      if @rental.update(rental_params)
        format.html { redirect_to rental_url(@rental), notice: "Rental was successfully updated." }
        format.json { render :show, status: :ok, location: @rental }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rental.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rentals/1 or /rentals/1.json
  def destroy
    @rental.destroy

    respond_to do |format|
      format.html { redirect_to rentals_url, notice: "Rental was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rental
      @rental = Rental.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rental_params
      if params["_method"] == "post"
        params.require(:rental).permit(:price, :expires, :user_id, :car_id)
      else
        params.require(:rental).permit(:price, :expires)
      end
    end


    def requirements
      notice = ''
      if params[:rental][:price].to_i > current_user.balance
        alert = "no tiene suficiente saldo"
      end

      last_rent = current_user.rental.first
      if last_rent && last_rent[:expires] < Time.now
        alert = "no puede alquialr este auto antes de 3 hs de su ultimo alquiler"
      end

      if !current_user.addmiss?
        alert = "debe estar habilitado para alquialr este auto"
      end

      if alert != ''
        redirect_to rentals_path, alert: alert
      end
    end
end
