# frozen_string_literal: true

module Operations
  module Office
    module Bookings
      class StartTheRent < Base
        def call(booking, responsible, starts_at = nil, ends_at = nil)
          started_rent_booking = yield start_the_rent(booking, starts_at, ends_at, responsible)
          Success(started_rent_booking)
        end

        private

        def start_the_rent(booking, starts_at, ends_at, responsible)
          audit_as_user(responsible) do
            booking.update!(
              status: "start_the_rent",
              actual_ends_at: ends_at,
              actual_starts_at: starts_at
            )
          end
          Success(booking.reload)
        end
      end
    end
  end
end
