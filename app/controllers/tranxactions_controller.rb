# frozen_string_literal: true

class TranxactionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @q = Tranxaction.ransack(params[:q])
    @q.sorts = 'date desc' if @q.sorts.empty?
    @tranxactions = @q.result(distinct: true).page(params[:page])
  end
end
