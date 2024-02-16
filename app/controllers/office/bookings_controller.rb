# frozen_string_literal: true

module Office
  class BookingsController < BaseController
    before_action :find_car_park, only: %i[create]

    def index
      @bookings = current_office_user.bookings.left_joins(:car, :client, :offer).group_by(&:status)
    end

    def new
      @booking = Booking.new
    end

    def create
      operation = Operations::Office::Bookings::Create.new
      result = operation.call(@car_park, booking_params.to_h)

      case result
      in Success[booking]
        respond_to do |format|
          format.js { render json: {booking: booking}, status: :created }
        end
      in Failure[error_code, errors]
        respond_to do |format|
          format.js { render json: {errors: errors}, status: :unprocessable_entity }
        end
      end
    end

    def show
      @booking = current_office_user.bookings.find(params[:id])
    end

    private

    def booking_params
      params.require(:booking).permit(
        :car_id,
        :client_id,
        :offer_id,
        :starts_at,
        :ends_at,
        :self_pickup,
        :self_drop_off,
        :pickup_location,
        :drop_off_location,
        :car,
        :client,
        :payment_method,
        services: {}
      )
    end

    def find_car_park
      @car_park = current_office_user.car_parks.find(params[:car_park_id])
    end
  end
end
