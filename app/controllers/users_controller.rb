class UsersController < ApplicationController
  before_filter :is_admin?

  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  def is_admin?
    if current_user.try(:admin?)
      true
    else
      render "users/access_denied"
    end
  end
end
