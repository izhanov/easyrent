# frozen_string_literal: true

module Utils
  module Bookings
    class Calculator
      attr_reader :booking

      def initialize(booking)
        @booking = booking
      end

      def run
        (booking.booked_dates_count * price_for_rent_period) + services_total_amount + booking_pledge_amount
      end

      def get(name)
        send(name)
      end

      private

      def offer
        @offer ||= booking.offer
      end

      def prices
        @prices ||=
          booking.offer.prices.transform_keys { |key| string_range_to_range(key) }
      end

      def services_prices
        @services_prices ||= booking.services
      end

      def services_total_amount
        @services_total_amount ||= booking.services.map do |service_id, price|
          service = AdditionalService.find_by(id: service_id)
          next unless service.present?

          if service.one_time?
            price_string_to_decimal(price)
          else
            price_string_to_decimal(price) * booking.booked_dates_count
          end
        end.compact.sum
      end

      def booking_pledge_amount
        @booking_pledge_amount ||= booking.pledge_amount
      end

      def booking_prepayment_amount
        @booking_prepayment_amount ||= booking.prepayment_amount
      end

      def booking_kaspi_method_amount
        @booking_kaspi_method_amount ||= booking.kaspi_method_amount
      end

      def booking_halyk_method_amount
        @booking_halyk_method_amount ||= booking.halyk_method_amount
      end

      def booking_chash_method_amount
        @booking_cash_method_amount ||= booking.cash_method_amount
      end

      def price_for_rent_period
        needed_range = prices.keys.detect { |range| range.cover?(booking.booked_dates_count) }

        if needed_range
          price_string_to_decimal(prices[needed_range])
        else
          nearest_range = prices.keys.min_by { |range| (range.max - booking.booked_dates_count).abs }
          price_string_to_decimal(prices[nearest_range])
        end
      end

      def string_range_to_range(string_range)
        Range.new(*string_range.split("..").map(&:to_i))
      end

      def price_string_to_decimal(price_string)
        BigDecimal(price_string.to_s.gsub(/[^0-9,.]/, ""))
      end
    end
  end
end
