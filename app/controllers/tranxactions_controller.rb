# frozen_string_literal: true

class TranxactionsController < ApplicationController
  before_action :authenticate_admin_user!
  before_action :set_tranxaction, only: %i[show update]

  def show
    render json: @tranxaction
  end

  def update
    if @tranxaction.update(tranxaction_params)
      render json: @tranxaction, status: :ok
    else
      render json: @tranxaction.errors, status: :unprocessable_entity
    end
  end

  def balance
    if params[:resource_type] && params[:resource_id]
      resource = params[:resource_type].constantize.find(params[:resource_id])
      t = resource.tranxactions
    else
      t = Tranxaction.all
    end

    if params[:from_date] && params[:to_date]
      t = t.where('date >= ?', params[:from_date].to_date)
           .where('date <= ?', params[:to_date].to_date)
    end

    if params[:tranxaction_type]
      t = t.where('amount < 0') if params[:tranxaction_type] == 'expense'
      t = t.where('amount > 0') if params[:tranxaction_type] == 'revenue'
    end

    t = t.where(tax: params[:tax]) if params[:tax]

    if params[:tax_category]
      tax_category = TaxCategory.find_by(description: params[:tax_category])
      t = t.where(tax_category_id: tax_category.id)
    end

    balance = t.sum(:amount)

    render :json => { balance: balance }, status => 200
  end

  private

  def set_tranxaction
    @tranxaction = Tranxaction.find(params[:id])
  end

  def tranxaction_params
    params.require(:tranxaction)
          .permit(:date,
                  :description,
                  :amount,
                  :tax,
                  :tax_category_id,
                  attachments_attributes: %i[url aws_key])
  end
end
