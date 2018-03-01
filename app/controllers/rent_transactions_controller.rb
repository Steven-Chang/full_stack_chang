class RentTransactionsController < ApplicationController
  before_action :set_rent_transaction, only: [:update, :destroy]

  def index
    user_id = params[:user_id]
    rent_transactions = RentTransaction.where(:user_id => user_id).order("date DESC")

    respond_to do |format|
      format.json {
        render :json => rent_transactions,
        status => 200
      }
    end
  end

  def create
    recent_transaction = RentTransaction.new( rent_transaction_params )
    respond_to do |format|
      if recent_transaction.save
        format.json { render :json => recent_transaction.to_json, status: :created }
      else
        format.json { render json: recent_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
  end

  def destroy
    @rent_transaction.destroy

    render json: { message: "removed" }, status: :ok
  end

  private

  def set_rent_transaction
    @rent_transaction = RentTransaction.find(params[:id])
  end

  def rent_transaction_params
    params.require(:rent_transaction).permit(:user_id, :date, :description, :amount)
  end
end
