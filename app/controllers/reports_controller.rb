class ReportsController < ApplicationController
  before_action :set_report, only: %i[ show edit update destroy ]

  # GET /reports or /reports.json
  def index
    @reports = Report.all.order(:created_at)
  end

  # GET /reports/1 or /reports/1.json
  def show
  end

  # GET /reports/new
  def new
    @report = Report.new()
  end

  # GET /reports/1/edit
  def edit
  end

  # POST /reports or /reports.json
  def create
    @report = Report.new(report_params)

    #Actualizar variable del motor encendido
    if Car.find(@report.car_id.to_i).turn_on?
      @report.engine_turned_on = true
    else
      @report.engine_turned_on = false
    end

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
         params.require(:report).permit(:description, :user_id, :car_id, :image, :state, :rental_start, :last_user_id, :engine_turned_on)
      else
         params.require(:report).permit(:description, :user_id, :car_id, :image, :state, :rental_start, :last_user_id, :engine_turned_on)
      end      
    end

end