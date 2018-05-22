class GamblingTransactionsController < ApplicationController
  before_filter :authenticate_user!
  before_action :authenticate_admin

  def index
    respond_to do |format|
      format.json { render :json => current_user.gambling_transactions, :status => 200 }
    end
  end

  def create
    gambling_transaction = GamblingTransaction.new( gambling_transaction_params )

    respond_to do |format|
      if gambling_transaction.save
        format.json { render :json => gambling_transaction, status: :created }
      else
        format.json { render json: gambling_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def gambling_transaction_params
    params.require( :gambling_transaction_params ).permit(:user_id, :amount, :description)
  end

  def authenticate_admin
    redirect_to root_path unless current_user && current_user.admin
  end
end
