# frozen_string_literal: true

module OfficeJobs
  module Bookings
    class RentEndJob < ApplicationJob
      queue_as :default

      def perform
        Booking.rent_ends_today.each do |booking|
          Operations::Office::Bookings::EndTheRent.new.call(booking, "system")
        end
      end
    end
  end
end
