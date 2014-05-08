class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters, :only => [:create]
  respond_to :json

  def create
    params[:user][:password_confirmation] = params[:user][:password]
    params[:user][:phone_number] = "+1"+params[:user][:phone_number].tr('() -','')
    super
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) do |u|
        u.permit(:first_name, :last_name, :phone_number, :email, :password)
      end
    end
end
