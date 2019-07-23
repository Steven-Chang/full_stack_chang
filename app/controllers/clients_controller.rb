# frozen_string_literal: true

class ClientsController < ApplicationController
  before_action :authenticate_admin_user!

  def index
    @clients = Client.all

    render json: @clients
  end
end
