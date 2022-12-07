class CarsController < ApplicationController
  before_action :set_car,   only: %i[ show edit update destroy turnedOn? ]

  # GET /cars or /cars.json
  def index
    @cars = Car.all
  end

  # GET /cars/1 or /cars/1.json
  def show
  end

  # GET /cars/new
  def new
    @car = Car.new
  end

  # GET /cars/1/edit
  def edit
  end

  # POST /cars or /cars.json
  def create
    @car = Car.new(car_params)

    respond_to do |format|
      if @car.save
        format.html { redirect_to request.referrer, notice: "El auto fue creado con éxito." }
        format.json { render :show, status: :created, location: @car }
      else
        if @car.errors.any?
          @car.errors.each do |error|
            format.html { redirect_to request.referrer, alert: error.message }
          end
        end
        format.html { redirect_to request.referrer, alert: "El auto no pudo ser creado." }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1 or /cars/1.json
  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to request.referrer, notice: "Auto actualizado." }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit, status: :unprocessable_entity}
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1 or /cars/1.json
  def destroy
    @car.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: "El auto fue borrado exitosamente." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_car
    @car = Car.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def car_params
    params.require(:car).permit(:model, :brand, :license, :color, :img_url, :doors, :seats, :state, :engine, :fuel, :position_id, :used, :turn_on, :coords_x, :coords_y, :car_photo)
  end


end
