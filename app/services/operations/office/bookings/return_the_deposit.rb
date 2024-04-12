# frozen_string_literal: true

module Operations
  module Office
    module Bookings
      class ReturnTheDeposit < Base
        def call(booking, responsible, ends_at = nil)
          returned_deposit_booking = yield return_the_deposit(booking, ends_at, responsible)
          Success(returned_deposit_booking)
        end

        private

        def return_the_deposit(booking, ends_at, responsible)
          audit_as_user(responsible) do
            booking.update!(status: "return_the_deposit", actual_ends_at: ends_at)
          end
          Success(booking.reload)
        end
      end
    end
  end
end
