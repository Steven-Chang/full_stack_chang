# frozen_string_literal: true

class TranxactionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @q = current_user.tranxactions.ransack(params[:q])
    @q.sorts = 'date desc' if @q.sorts.empty?
    @tranxactions = @q.result(distinct: true).page(params[:page])
  end

  def show
    @tranxaction = current_user.tranxactions.find(params[:id])
  end

  def new
    @tranxaction = current_user.tranxactions.new
    @tranxaction.tranxactable_type = nil
  end

  def create
    @tranxaction = current_user.tranxactions.new(tranxaction_params)
    if @tranxaction.save
      redirect_to @tranxaction, notice: 'Transaction was successfully created.'
    else
      render action: "new"
    end
  end

  def edit
    @tranxaction = current_user.tranxactions.find(params[:id])
  end

  def destroy
    @tranxaction = current_user.tranxactions.find(params[:id])
    @tranxaction.destroy
    redirect_to tranxactions_path, notice: 'Transaction deleted'
  end

  private

    def tranxaction_params
      params.require(:tranxaction).permit(:date, :description, :amount, :tax, :tax_category_id, :creditor_id, :tranxactable_type, :tranxactable_id, attachments: [])
    end
end
