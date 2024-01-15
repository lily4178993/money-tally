class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_sign_up_params, if: :devise_controller?

  rescue_from CanCan: :AccessDenied do |exception|
    redirect_to main_app.root_url, alert: exception.message
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up) do |user|
      user.permit(:name, :email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.permit(:sign_in) do |user|
      user.permit(:email, :password)
    end
  end
end
