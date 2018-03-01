class RentTransactionsController < ApplicationController
  before_action :set_rent_transaction, only: [:update, :destroy]

  def index
    user_id = params[:user_id]
    rent_transactions = RentTransaction.where(:user_id => user_id)

    respond_to do |format|
      format.json {
        render :json => rent_transactions,
        status => 200
      }
    end
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

  def set_rent_transaction
    @rent_transaction = RentTransaction.find(params[:id])
  end

  def rent_transaction_params
    params.require(:rent_transaction).permit(:user_id, :date, :description, :amount)
  end
end
