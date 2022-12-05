class CardsController < ApplicationController
  before_action :set_card, only: %i[ show edit update balance destroy ]

  # GET /cards or /cards.json
  def index
    @cards = Card.all
  end

  # GET /cards/1 or /cards/1.json
  def show
  end

  # GET /cards/new
  def new
    @card = Card.new
  end

  # GET /cards/1/edit
  def edit
  end

  # POST /cards or /cards.json
  def create
    @card = Card.new(card_params)

    alert = ""
    if !@card.number.nil? && !@card.expires.nil?
      if @card.number.to_s.length == 12 && @card.expires > Time.now && @card.bankName != 'banco'
        respond_to do |format|
          if @card.update(card_params)
            format.html { redirect_to user_path(current_user), notice: "La tarjeta ha sigo agregada con exito." }
            format.json { render "users/show", status: :ok, location: current_user }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @card.errors, status: :unprocessable_entity }
          end
        end

      else
        if @card.number.to_s.length != 12
          alert += "El numero de tarjeta debe tener 12 digitos"
        end
        
        if @card.expires <= Time.now
          alert += !alert.empty? ? " y " : ""
          alert += "La fecha de expiracion ya ha pasado"
        end

        if @card.bankName != 'banco'
          alert += !alert.empty? ? " y " : ""
          alert += "Debe elegir un banco"
        end
      end
    
    else
      alert = "Faltan datos"
    end
      
    if !alert.empty?
      redirect_to new_card_path, alert: alert
    end
  end

  # PATCH/PUT /cards/1 or /cards/1.json
  def update
    respond_to do |format|
      if @card.update(card_params)
        format.html { redirect_to card_url(@card), notice: "Card was successfully updated." }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # Agregar saldo al usuario de su la tarjeta
  def balance
    extraction = params[:card][:balance].to_i
    if @card.balance >= extraction
      # Actualiza los balances de la tarjeta y su usuario
      # Resta la transferencia de dinero al balance de la tarjeta y la suma al balance del usuario
      @card.update(balance: @card.balance - extraction)
      current_user.update(balance: current_user.balance + extraction)
   
      notice = "Saldo acreditado correctamente"

    else
      alert = "Su tarjeta no posee suficiente saldo como para realizar esta transferencia (Saldo disponible en la tarjeta: $#{@card.balance})"
    end

    redirect_to user_path(current_user), alert: alert, notice: notice
  end

  # DELETE /cards/1 or /cards/1.json
  def destroy
    @card.destroy

    respond_to do |format|
      format.html { redirect_to user_path(current_user), notice: "La tarjeta fue eliminada exitosamente." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def card_params
      params.require(:card).permit(:number, :expires, :bankName, :user_id)
    end
end
