# frozen_string_literal: true

# :reek:MissingSafeMethod { exclude: [ authenticate_admin_user! ] }
class ApplicationController < ActionController::Base
  # === INCLUDES ===
  include Pundit::Authorization

  # === CALLBACKS ===
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def after_sign_out_path_for(_resource_or_scope)
      '/'
    end

    def configure_permitted_parameters
      added_attrs = %i[
        username
      ]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      devise_parameter_sanitizer.permit :account_update, keys: added_attrs
      devise_parameter_sanitizer.permit(:sign_in, keys: [:otp_attempt])
    end

    # use predefined method name
    def authenticate_admin_user!
      return access_denied if user_signed_in? && !current_user.admin?

      authenticate_user!
    end

    def access_denied
      flash[:alert] = 'You are not authorized to perform this action.'
      redirect_to(root_path)
    end
end
