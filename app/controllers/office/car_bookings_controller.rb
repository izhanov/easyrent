class Office::CarBookingsController < Office::BaseController
  def index
    @cars = Operations::Office::Cars::Search.new(
      car: params[:car],
      city_id: params[:city_id],
      starts_at: date_from,
      ends_at: date_to
    ).call

    @cars = current_office_user.cars.where(id: @cars.pluck(:id)).order(:id)
    @cars = @cars.where(owner_id: params[:car_park_id]) if params[:car_park_id].present?

    @date_from = params[:date_from] || DateTime.current
    @date_to = params[:date_to] || DateTime.current + 1.day
    @pagy, @cars = pagy(@cars, items: 10)
  end

  private

  def date_from
    params[:date_from].presence || Time.zone.now.beginning_of_day
  end

  def date_to
    params[:date_to].presence || Time.zone.now.end_of_day # or tommorow 00:00?
  end
end
