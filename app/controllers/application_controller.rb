# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  skip_before_action :verify_authenticity_token

  respond_to :json

  def index
    render 'application/index'
  end

  protected

  def configure_permitted_parameters
    added_attrs = %i[
      username
      email
      password
      tenant
      first_name
      last_name
    ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def authenticate_admin
    redirect_to root_path unless current_user && current_user&.admin
  end
end
