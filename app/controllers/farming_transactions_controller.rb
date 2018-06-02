class FarmingTransactionsController < ApplicationController
  before_filter :authenticate_user!
  before_action :authenticate_admin
  before_action :set_farming_transaction, only: [:destroy]

  def index
    respond_to do |format|
      format.json { render :json => current_user.farming_transactions, :status => 200 }
    end
  end

  def create
    farming_transaction = FarmingTransaction.new( farming_transaction_params )
    farming_transaction.user_id = current_user.id

    respond_to do |format|
      if farming_transaction.save
        format.json { render :json => farming_transaction, status: :created }
      else
        format.json { render json: farming_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @farming_transaction.destroy

    render json: { message: "removed" }, status: :ok
  end

  private

  def farming_transaction_params
    params.require( :farming_transaction ).permit(:user_id, :amount, :description, :date, :odds, :farming)
  end

  def authenticate_admin
    redirect_to root_path unless current_user && current_user.admin
  end

  def set_farming_transaction
    @farming_transaction = FarmingTransaction.find( params[:id] )
  end
end
