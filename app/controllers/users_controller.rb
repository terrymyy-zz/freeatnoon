class UsersController < ApplicationController
  before_filter :is_admin?

  def index
    @users = User.all.order(:created_at)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end
end
