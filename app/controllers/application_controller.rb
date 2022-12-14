class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  helper_method :current_user_can_edit?

  def set_locale 
    I18n.locale = :ru
  end

  def configure_permitted_parameters
  	devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :password, :password_confirmation, :current_password, :avatar])
  end

  def current_user_can_edit?(model)
    user_signed_in? && 
    (model&.user == current_user || (model.try(:event).present? && model.event.user == current_user))
  end
end
