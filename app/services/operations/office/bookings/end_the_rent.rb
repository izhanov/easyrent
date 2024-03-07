# frozen_string_literal: true

module Operations
  module Office
    module Bookings
      class EndTheRent < Base
        def call(booking, responsible)
          ended_rent_booking = yield end_the_rent(booking, responsible)
          Success(ended_rent_booking)
        end

        private

        def end_the_rent(booking, responsible)
          audit_as_user(responsible) do
            booking.update!(status: "end_the_rent")
          end
          Success(booking.reload)
        end
      end
    end
  end
end
