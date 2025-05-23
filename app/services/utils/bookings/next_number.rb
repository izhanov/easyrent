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
        "#{owner_booking_prefix}#{Time.current.strftime("%Y%m%d")}-#{next_number}"
      end

      private

      def current_day_bookings
        Booking.left_joins(:car).where(
          cars_table[:owner_id].eq(car.owner_id).and(
            date_function(bookings_table[:created_at]).eq(Time.current.to_date)
          )
        )
      end

      def bookings_table
        Booking.arel_table
      end

      def cars_table
        Car.arel_table
      end

      def date_function(field)
        Arel::Nodes::NamedFunction.new("DATE", [field])
      end
    end
  end
end
