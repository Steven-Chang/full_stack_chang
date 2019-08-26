# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit

  def home
    @body_class = 'animsition page-maintenance layout-full'
    @page_title = 'Home | fullstackchang.com'
  end

  protected

  def configure_permitted_parameters
    added_attrs = %i[
      username
    ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  # use predefined method name
  def authenticate_admin_user!
    return user_not_authorized if user_signed_in? && !current_user.admin?

    authenticate_user!
  end

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referer || root_path)
  end
end
