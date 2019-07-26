# frozen_string_literal: true

class PaymentSummariesController < ApplicationController
  before_action :authenticate_admin_user!

  def index
    @payment_summaries = if params[:client_id]
      Client.find(params[:client_id]).payment_summaries
    elsif params[:year_ending]
      PaymentSummary.where(year_ending: params[:year_ending])
    else
      PaymentSummary.all
    end

    render json: @payment_summaries
  end
end
