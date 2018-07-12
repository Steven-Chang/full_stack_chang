class TranxactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin

  def index
    @tranxactions = Tranxaction.all

    render :json => @tranxactions
  end
end
