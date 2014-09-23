class UsersController < ApplicationController
  before_filter :is_admin?

  def index
    @users = User.all.order("created_at DESC")
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path
  end

  def toggle_mute
    user = User.find(params[:id])
    user.mute = !user.mute
    user.save
    redirect_to users_path
  end
end
