class FreeTimesController < ApplicationController
  def new
  end

  def create
    current_user.free_times.create(free_times_params)
    render json: { result: "success" }
  end

  private

  def free_times_params
    params.require(:free_times).map { |ft| ft.permit(:day, :time, :duration) }
  end
end
