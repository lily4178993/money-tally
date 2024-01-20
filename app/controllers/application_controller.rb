class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_sign_up_params, if: :devise_controller?

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up) do |user|
      user.permit(:profile_photo, :name, :email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.permit(:sign_in) do |user|
      user.permit(:email, :password)
    end
  end
end
