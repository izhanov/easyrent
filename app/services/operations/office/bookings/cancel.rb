# frozen_string_literal: true

module Operations
  module Office
    module Bookings
      class Cancel < Base
        def call(booking, responsible)
          cancelled_booking = yield cancel(booking, responsible)
          Success(cancelled_booking)
        end

        private

        def cancel(booking, responsible)
          audit_as_user(responsible) do
            booking.update!(status: "cancelled")
            Operations::Office::Cars::Release.new.call(booking.car, responsible)
          end
          Success(booking.reload)
        end
      end
    end
  end
end
