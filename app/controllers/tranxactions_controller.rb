class TranxactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin

  def index
    if params[:resource_type] && params[:resource_id]
      @tranxactions = params[:resource_type].constantize.find(params[:resource_id]).tranxactions
    else
      @tranxactions = Tranxaction.all
    end

    render :json => @tranxactions.order(date: :desc)
  end

  def create
    tranxaction = Tranxaction.new( tranxaction_params )
    Tranxaction.transaction do
      tranxaction.save
      params[:tranxactables].each do |tranxactable|
        Tranxactable.create(resource_type: tranxactable[:resource_type], resource_id: tranxactable[:resource_id], tranxaction_id: tranxaction.id)
      end

      params[:attachments].each do |attachment|
        response = Aws::S3::Client.new.put_object(
          bucket: ENV['BUCKETEER_BUCKET_NAME'],
          key: "uploads/#{ tranxaction.id }/#{ attachment[:name] }",
          body: File.read( attachment ).open
        )

        puts response
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
