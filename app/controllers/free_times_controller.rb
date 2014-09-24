class FreeTimesController < ApplicationController
  def new
  end

  def edit
  end

  def create
    new_user = false
    if current_user.free_times.present?
      current_user.free_times.delete_all
    else
      new_user = true
    end

    current_user.free_times.create(free_times_params)
    render json: { result: "success", new_user: new_user }
  end

  private

  def free_times_params
    params.require(:free_times).map { |ft| ft.permit(:day, :time, :duration) }
  end
end
