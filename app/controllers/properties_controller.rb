# frozen_string_literal: true

class PropertiesController < ApplicationController
  before_action :authenticate_admin_user!

  def index
    @properties = Property.all

    render json: @properties
  end
end
