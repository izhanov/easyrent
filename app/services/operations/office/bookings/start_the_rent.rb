# frozen_string_literal: true

module Operations
  module Office
    module Bookings
      class StartTheRent < Base
        def call(booking, responsible)
          started_rent_booking = yield start_the_rent(booking, responsible)
          Success(started_rent_booking)
        end

        private

        def start_the_rent(booking, responsible)
          audit_as_user(responsible) do
            booking.update!(status: "start_the_rent")
          end
          Success(booking.reload)
        end
      end
    end
  end
end
