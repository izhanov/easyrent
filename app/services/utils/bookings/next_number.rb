# frozen_string_literal: true

module Utils
  module Bookings
    class NextNumber
      attr_reader :car

      def initialize(car_id)
        @car = Car.find(car_id)
      end

      def get
        current_number = current_day_bookings.size
        next_number = current_number + 1
        owner_booking_prefix = car.owner.booking_prefix
        "#{owner_booking_prefix}#{Date.current.strftime("%Y%m%d")}-#{next_number}"
      end

      private

      def current_day_bookings
        Booking.where(
          bookings_table[:car_id].eq(car.id).
            and(
              date_function(bookings_table[:created_at]).eq(Date.current)
            )
        )
      end

      def bookings_table
        Booking.arel_table
      end

      def date_function(field)
        Arel::Nodes::NamedFunction.new("DATE", [field])
      end
    end
  end
end
