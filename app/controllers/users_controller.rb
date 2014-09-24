class UsersController < ApplicationController
  before_filter :is_admin?, except: [:send_reminder]

  def index
    @users = User.all.order("created_at DESC")
  end

  def show
    @user = User.find(params[:id])
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

  def send_reminder
    UserMailer.send_time_input_reminder(current_user).deliver
    render json: { result: "success" }
  end
end
