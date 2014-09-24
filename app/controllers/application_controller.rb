class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  after_filter :discard_flash_if_xhr

  def after_sign_in_path_for(resource)
    if current_user.try(:admin?)
      users_path
    else
      edit_free_time_path(resource)
    end
  end

  protected
  def discard_flash_if_xhr
    flash.discard if request.xhr?
  end

  def is_admin?
    if current_user.try(:admin?)
      true
    else
      return render "users/access_denied"
    end
  end
end
