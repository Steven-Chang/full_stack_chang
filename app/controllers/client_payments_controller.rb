class ClientPaymentsController < ApplicationController
  before_action :set_client_payment, only: [:show, :edit, :update, :destroy]

  # GET /client_payments
  # GET /client_payments.json
  def index
    @client_payments = ClientPayment.all
    puts @client_payments

    render :json => @client_payments
  end

  # GET /client_payments/1
  # GET /client_payments/1.json
  def show
  end

  # GET /client_payments/new
  def new
    @client_payment = ClientPayment.new
  end

  # GET /client_payments/1/edit
  def edit
  end

  # POST /client_payments
  # POST /client_payments.json
  def create
    @client_payment = ClientPayment.new(client_payment_params)

    respond_to do |format|
      if @client_payment.save
        format.json { render :json => @client_payment, status: :created }
      else
        format.json { render json: @client_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /client_payments/1
  # PATCH/PUT /client_payments/1.json
  def update
    respond_to do |format|
      if @client_payment.update(client_payment_params)
        format.html { redirect_to @client_payment, notice: 'Client payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @client_payment }
      else
        format.html { render :edit }
        format.json { render json: @client_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /client_payments/1
  # DELETE /client_payments/1.json
  def destroy
    @client_payment.destroy
    respond_to do |format|
      format.html { redirect_to client_payments_url, notice: 'Client payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_payment
      @client_payment = ClientPayment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_payment_params
      params.require( :client_payment ).permit( :client_id, :amount, :date )
    end
end
