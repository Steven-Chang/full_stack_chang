# frozen_string_literal: true

class AttachmentsController < ApplicationController
  before_action :set_attachment, only: %i[edit update destroy]
  before_action :authenticate_user!
  before_action :authenticate_admin

  def index
    @attachments = Attachment.all
  end

  def new
    @attachment = Attachment.new
  end

  def edit; end

  def create
    @attachment = Attachment.new(attachment_params)

    respond_to do |format|
      if @attachment.save
        format.html { redirect_to @attachment, notice: 'Attachment was successfully created.' }
        format.json { render :show, status: :created, location: @attachment }
      else
        format.html { render :new }
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @attachment.update(attachment_params)
        format.html { redirect_to @attachment, notice: 'Attachment was successfully updated.' }
        format.json { render :show, status: :ok, location: @attachment }
      else
        format.html { render :edit }
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @attachment.destroy
    respond_to do |format|
      format.html { redirect_to attachments_url, notice: 'Attachment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def presigned
    if params[:filename]
      bucket_name = Rails.application.credentials.aws[:bucket_name]
      extname = File.extname(params[:filename])
      filename = "#{SecureRandom.uuid}#{extname}"
      upload_key = Pathname.new('uploads/').join(filename).to_s
      obj = Attachment.aws_resource.bucket(bucket_name).object(upload_key)

      params = { acl: 'public-read' }
      params[:content_length] = limit if params[:limit]

      render json: {
        aws_key: upload_key,
        presigned_url: obj.presigned_url(:put, params),
        public_url: obj.public_url
      }
    else
      render json: { error: 'Invalid Params' }
    end
  end

  private

  def set_attachment
    @attachment = Attachment.find(params[:id])
  end

  def attachment_params
    params.fetch(:attachment, {})
  end
end
