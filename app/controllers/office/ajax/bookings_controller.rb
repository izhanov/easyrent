# frozen_string_literal: true

module Office
  module AJAX
    class BookingsController < BaseController
      def calculate
        @booking = Booking.new(booking_params)
      end

      private

      def booking_params
        params.require(:booking).permit(
          :offer_id,
          :starts_at,
          :ends_at,
          :pledge_amount,
          :with_pledge_amount,
          services: {}
        )
      end
    end
  end
end
