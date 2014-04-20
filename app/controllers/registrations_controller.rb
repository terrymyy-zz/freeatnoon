class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters, :only => [:create]

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) do |u|
        u.permit(:first_name, :last_name, :phone_number, :email, :password)
      end
    end
end
