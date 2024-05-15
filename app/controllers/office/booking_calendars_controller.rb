# frozen_string_literal: true

module Office
  class BookingCalendarsController < BaseController
    def show
      @month = define_month
      @q = Car.typesense(
        q: params.dig(:q, :query),
        query_by: "plate_number, mark.title, color, vin_code, klass, mark.synonyms",
        infix: "always, always, always, always, always, always",
        per_page: 250
      )
      @pagy, @cars = pagy(current_office_user.cars.where(id: @q.pluck(:id), owner_id: params.dig(:q, :car_park_id) || current_office_user.car_parks.first.id))
      @bookings = Booking.where(car_id: @cars.ids).group_by(&:car_id)
    end

    private

    def define_month
      date = params.dig(:q, :month)&.to_date || Date.current
      (date.to_date.beginning_of_month..date.to_date.end_of_month)
    end
  end
end
