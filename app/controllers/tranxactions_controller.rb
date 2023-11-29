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
end
