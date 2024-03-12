# frozen_string_literal: true

module Operations
  module Office
    module Bookings
      class Complete < Base
        def call(booking, responsible)
          completed_booking = yield complete(booking, responsible)
          Success(completed_booking)
        end

        private

        def complete(booking, responsible)
          audit_as_user(responsible) do
            booking.update!(status: "completed")
            Operations::Office::Cars::Release.new.call(booking.car, responsible)
          end
          Success(booking.reload)
        end
      end
    end
  end
end
