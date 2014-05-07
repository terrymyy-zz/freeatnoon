class BadDatesController < ApplicationController
  def create
    if params[:leaving_date]
      current_user.leaving_date = params[:leaving_date]
      current_user.save
    end
    current_user.bad_dates.create(bad_dates_params)
    render json: { result: "success" }
  end

  def bad_dates_params
    params.require(:bad_dates).map { |bd| bd.permit(:date) }
  end
end
