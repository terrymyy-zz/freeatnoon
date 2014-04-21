class FreeTimesController < ApplicationController
  def new
  end

  def create
    FreeTime.create(free_time_params)
    render text: params.inspect and return
  end

  private

  def free_time_params
    params.require(:free_time).permit(:day, :time, :duration)
  end
end
