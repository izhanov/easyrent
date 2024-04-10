# frozen_string_literal: true

module Utils
  module Contracts
    class NextNumber
      attr_reader :booking

      def initialize(booking)
        @booking = booking
      end

      def get
        "#{Date.current.year}#{next_number}"
      end

      private

      def next_number
        current_day_bookings
      end

      def current_day_bookings
        car_park = booking.car.owner
        car_park.bookings.size
      end

      def contracts_table
        Contract.arel_table
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
