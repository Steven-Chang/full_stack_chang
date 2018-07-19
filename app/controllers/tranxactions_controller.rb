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
    extname = File.extname(params[:filename])
    filename = "#{SecureRandom.uuid}#{extname}"
    upload_key = Pathname.new( "uploads/" ).join(filename).to_s

    creds = Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
    s3 = Aws::S3::Resource.new(region: 'ap-southeast-2', credentials: creds)
    obj = s3.bucket(ENV['BUCKET_NAME_TEMPORARY']).object(upload_key)

    params = { acl: 'public-read' }
    params[:content_length] = limit if params[:limit]

    render :json => {
      presigned_url: obj.presigned_url(:put, params),
      public_url: obj.public_url
    }
  else
    render :json => {:error => 'Invalid Params'}
  end
end

  private

  def tranxaction_params
    params.require(:tranxaction).permit(:date, :description, :amount, :tax, { attachments: [] })
  end
end
