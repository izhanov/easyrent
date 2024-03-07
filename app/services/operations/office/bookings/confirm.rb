# frozen_string_literal: true

module Operations
  module Office
    module Bookings
      class Confirm < Base
        def call(booking, responsible)
          confirmed_booking = yield confirm(booking, responsible)
          Success(confirmed_booking)
        end

        private

        def confirm(booking, responsible)
          ActiveRecord::Base.transaction do
            audit_as_user(responsible) do
              booking.update!(status: "confirmed")
              Operations::Office::Cars::Occupy.new.call(booking.car, responsible)
            end
            Success(booking.reload)
          end
        end
      end
    end
  end
end
