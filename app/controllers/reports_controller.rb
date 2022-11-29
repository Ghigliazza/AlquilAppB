class ReportsController < ApplicationController
  before_action :set_report, only: %i[ show edit update destroy ]

  # GET /reports or /reports.json
  def index
    @reports = Report.all
  end

  # GET /reports/1 or /reports/1.json
  def show
  end

  # GET /reports/new
  def new
    @report = Report.new()
    if (!current_user.rentals.any?)
      flash[:notice] = "No poder reportar un auto porque no tenes ningun alquiler."
      redirect_to root_path
      return 1
    end
    # Busca el último auto que usó el usuario, el que está rentado.
    car = current_user.rentals.last.car
    @report.car.id = car.id

    if (!car.status.rented?)
      # El auto, por alguna extraña razón, no está alquilado.
      flash[:notice] = "No podes reportar un auto que no alquilaste."
      redirect_to root_path
      return 1
    end
    
    if (((Time.new - current_user.rentals.last.created_at) <= 600) && (!car.turn_on?)) 
      if (!car.rentals.second.exists?(2))
       # No podemos saber quién es el responsable en este caso, asi
       # que dejamos vacio el id del usuario. 
        reporte_exitoso
        return 0
      end 
      # Busqueda de la anteultima renta que tuvo el auto
      # Es decir, a la renta anterior al usuario actual.
      rental = Rental.find(car.rentals.last(2).first)
      # id del usuario responsable (el anteultimo)
      @report.user.id = rental.user.id
      reporte_exitoso
      return 0
    else
      @report.user.id = current_user.id
      reporte_exitoso
      return 0
     end
    # if current_user.rentals.any? #Esta es la logica para que no te deje entrar
    #     sin rentas
    # @report.car_id = current_user.rentals.last.car_id
    #    else
    #    flash[:notice] = "You don't have any rentals"
    #       redirect_to "/reports"
    #     end

  end

  # GET /reports/1/edit
  def edit
  end

  # POST /reports or /reports.json
  def create
    @report = Report.new(report_params)

    respond_to do |format|
      if @report.save
        format.html { redirect_to request.referrer, notice: "El reporte fue enviado correctamente." }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { redirect_to request.referrer, alert: "El reporte no pudo ser enviado." }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1 or /reports/1.json
  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to report_url(@report), notice: "Report was successfully updated." }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1 or /reports/1.json
  def destroy
    @report.destroy

    respond_to do |format|
      format.html { redirect_to reports_url, notice: "El reporte fue eliminado correctamente" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      if Report.any?
      @report = Report.find(params[:id])
      else
        flash[:message] = "There is no report."
      end
    end

    # Only allow a list of trusted parameters through.
    def report_params
      if request.method() == "POST"
         params.require(:report).permit(:description, :user_id, :car_id, :image, :state)
      else
         params.require(:report).permit(:description, :user_id, :car_id, :image, :state)
      end      
    end

    private
    def reporte_exitoso
      flash[:notice] = "El reporte se envío correctamente."
      redirect_to root_path
    end



end