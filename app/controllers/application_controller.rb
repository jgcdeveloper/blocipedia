# This is the basic application controller
class ApplicationController < ActionController::Base
  include Pundit
  include ApplicationHelper

  #before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    flash[:alert] = t "#{policy_name}.#{exception.query}", scope: 'pundit', default: :default
    redirect_to(request.referrer || wikis_path)
  end

  protected

  def configure_permitted_parameters
    # Sanitizer for Devise Account Signup
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # Sanitizer for Devise Account Edit
    devise_parameter_sanitizer.permit(:account_update, keys:[:name])
  end
end
