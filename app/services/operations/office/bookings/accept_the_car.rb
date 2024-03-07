# frozen_string_literal: true

module Operations
  module Office
    module Bookings
      class AcceptTheCar < Base
        def call(booking, responsible)
          accepted_the_car_booking = yield accept_the_car(booking, responsible)
          Success(accepted_the_car_booking)
        end

        private

        def accept_the_car(booking, responsible)
          ActiveRecord::Base.transaction do
            audit_as_user(responsible) do
              booking.update!(status: "accept_the_car")
            end
            Success(booking.reload)
          end
        end
      end
    end
  end
end
