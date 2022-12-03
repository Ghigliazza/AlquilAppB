class FinesController < ApplicationController
  before_action :set_fine, only: %i[ show edit update destroy ]

  # GET /fines or /fines.json
  def index
    @fines = Fine.all
  end

  # GET /fines/1 or /fines/1.json
  def show
  end

  # GET /fines/new
  def new
    @fine = Fine.new
  end

  # GET /fines/1/edit
  def edit
  end

  # POST /fines or /fines.json
  def create
    @fine = Fine.new(fine_params)

    respond_to do |format|
      if @fine.save
        balance_aux = User.find(@fine.user_id).balance
        balance_aux = balance_aux - @fine.amount
        User.find(@fine.user_id).update(balance:balance_aux)

        format.html { redirect_to request.referrer, notice: "Multa procesada correctamente." }
        format.json { render :show, status: :created, location: @fine }
      else
        if @fine.errors.any?
          @fine.errors.each do |error|
            if error.full_message == "must exist"
              format.html { redirect_to request.referrer, alert: "El usuario no existe" }
            end
            format.html { redirect_to request.referrer, alert: error.message }
          end
        end 
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fines/1 or /fines/1.json
  def update
    respond_to do |format|
      if @fine.update(fine_params)
        format.html { redirect_to fine_url(@fine), notice: "Fine was successfully updated." }
        format.json { render :show, status: :ok, location: @fine }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @fine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fines/1 or /fines/1.json
  def destroy
    @fine.destroy

    respond_to do |format|
      format.html { redirect_to fines_url, notice: "Fine was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fine
      @fine = Fine.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def fine_params
      params.require(:fine).permit(:amount, :motive, :user_id)
    end
end
