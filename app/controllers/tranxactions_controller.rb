class TranxactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin
  before_action :set_tranxaction, only: [:destroy, :show, :update]

  def index
    if params[:resource_type] && params[:resource_id]
      @tranxactions = params[:resource_type].constantize.find(params[:resource_id]).tranxactions
    else
      @tranxactions = Tranxaction.all
    end

    render :json => @tranxactions.order(date: :desc)
  end

  def show
    render :json => @tranxaction
  end

  def create
    tranxaction = Tranxaction.new( tranxaction_params )
    Tranxaction.transaction do
      tranxaction.save
      params[:tranxactables].each do |tranxactable|
        Tranxactable.create(resource_type: tranxactable[:resource_type], resource_id: tranxactable[:resource_id], tranxaction_id: tranxaction.id)
      end

      params[:attachments].each do |attachment|
        Attachment.create(resource_type: "Tranxaction", resource_id: tranxaction.id, url: attachment[:url], aws_key: attachment[:aws_key] )
      end if params[:attachments]
    end

    if tranxaction.persisted?
      render :json => tranxaction
    else
      render :json => tranxaction.errors
    end
  end

  def update
    if @tranxaction.update( tranxaction_params )
      render :json => @tranxaction, status: :ok
    else
      render :json => @tranxaction.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @tranxaction.destroy
      render json: { message: "removed" }, status: :ok
    else
      render json: { message: "Error" }, status: :expectation_failed
    end
  end

  private

  def set_tranxaction
    @tranxaction = Tranxaction.find( params[:id] )
  end

  def tranxaction_params
    params.require(:tranxaction).permit(:date, :description, :amount, :tax, { attachments: [] })
  end
end
