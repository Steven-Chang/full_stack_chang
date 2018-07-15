class TranxactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin

  def index
    @tranxactions = Tranxaction.all

    render :json => @tranxactions
  end

  def create
    tranxaction = Tranxaction.new( tranxaction_params )
    Tranxaction.transaction do
      tranxaction.save
      params[:tranxactables].each do |tranxactable|
        Tranxactable.create(resource_type: tranxactable.resource_type, resource_id: tranxactable.resource_id, tranxaction_id: tranxaction.id)
      end
    end

    if tranxaction.persisted?
      render :json => tranxaction
    else
      render :json => tranxaction.errors
    end
  end

  private

  def tranxaction_params
    params.require(:tranxaction).permit(:date, :description, :amount, :tax)
  end
end
