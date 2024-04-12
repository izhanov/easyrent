# frozen_string_literal: true

module Operations
  module Office
    module Bookings
      class Complete < Base
        def call(booking, responsible, ends_at = nil)
          completed_booking = yield complete(booking, ends_at, responsible)
          Success(completed_booking)
        end

        private

        def complete(booking, ends_at, responsible)
          audit_as_user(responsible) do
            booking.update!(status: "completed", actual_ends_at: ends_at)
            Operations::Office::Cars::Release.new.call(booking.car, responsible)
          end
          Success(booking.reload)
        end
      end
    end
  end
end
