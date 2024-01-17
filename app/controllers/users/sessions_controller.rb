module Users
  class SessionsController < Devise::SessionsController
    def after_sign_in_path_for(resource)
      authenticated_root_path
    end

    def after_sign_out_path_for(resource)
      root_path
    end
  end
end