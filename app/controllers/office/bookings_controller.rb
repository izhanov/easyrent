# frozen_string_literal: true

module Office
  class BookingsController < BaseController
    def index
      @bookings = current_office_user.bookings
    end

    def new
      @booking = Booking.new
    end

    def create
      operation = Operations::Office::Bookings::Create.new
      result = operation.call(booking_params)

      case result
      in Success[booking]
        @booking = booking
        respond_to do |format|
          format.html
          format.turbo_stream
        end
      in Failure[:validation_error, errors]
        @booking = Booking.new(booking_params)
        @errors = errors
        render :new, status: :unprocessable_entitys
      end
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
        :drop_off_location
      )
    end
  end
end
