class BadDatesController < ApplicationController
  def create
    current_user.bad_dates.create(bad_dates_params)
    render json: "success"
  end

  def bad_dates_params
    params.require(:bad_dates).map { |ft| ft.permit(:date) }
  end
end
