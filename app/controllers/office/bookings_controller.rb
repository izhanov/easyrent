# frozen_string_literal: true

module Office
  class BookingsController < BaseController
    around_action :set_time_zone, if: :current_office_user

    def index
      @bookings = current_office_user.bookings
    end

    def new
      @booking = Booking.new
    end

    def create
      operation = Operations::Office::Bookings::Create.new
      puts booking_params.to_h
      result = operation.call(current_office_user, booking_params.to_h)
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

    def set_time_zone(&block)
      Time.use_zone("Asia/Almaty", &block)
    end
  end
end
