# frozen_string_literal: true

module Operations
  module Office
    module Bookings
      class GiveOutTheCar < Base
        def call(booking, responsible)
          given_out_car_booking = yield give_out_the_car(booking, responsible)
          Success(given_out_car_booking)
        end

        private

        def give_out_the_car(booking, responsible)
          audit_as_user(responsible) do
            booking.update!(status: "give_out_the_car")
          end
          Success(booking.reload)
        end
      end
    end
  end
end
