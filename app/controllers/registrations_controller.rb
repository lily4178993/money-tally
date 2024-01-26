class RegistrationsController < Devise::RegistrationsController
  protected

  def update_resource(resource, params)
    if params[:password].blank? && params[:password_confirmation].blank?
      resource.update_without_password(params)
    else
      resource.update_with_password(params)
    end
  end

  private

  def devise_mapping
    request.env['devise.mapping'] ||= Devise.mappings[:user] || Devise.mappings.values.first
  end
end
