# frozen_string_literal: true

class ClientsController < ApplicationController
  before_action :authenticate_admin_user!
  before_action :set_client, only: %i[show edit update destroy]

  def index
    @clients = Client.all

    render json: @clients
  end

  def show
    render json: @client
  end

  def new
    @client = Client.new
  end

  def edit; end

  def create
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        format.json { render json: @client, status: :created }
      else
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @client.update(client_params)
        format.json { render :show, status: :ok, location: @client }
      else
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @client.destroy
    render json: { message: 'removed' }, status: :ok
  end

  private

  def set_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:email, :name)
  end
end
