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
    end

    if tranxaction.persisted?
      render :json => tranxaction
    else
      render :json => tranxaction.errors
    end
  end

  def presigned
    if params[:filename] && params[:type]
      s3 = AWS::S3.new
      obj = s3.buckets[ENV["BUCKET_NAME"]].objects[params[:filename]]
      url = obj.url_for(:write, :content_type => params[:type], :expires => 10*60)  # Expires 10 Minutes
      render :json => {:url => url.to_s}
    else
      render :json => {:error => 'Invalid Params'}
    end
  end

  private

  def tranxaction_params
    params.require(:tranxaction).permit(:date, :description, :amount, :tax, { attachments: [] })
  end
end
