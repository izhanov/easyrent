# frozen_string_literal: true

module Office
  module BookingsAcceptance
    class CompletedController < BaseController
      def index
        @bookings = current_office_user.bookings
      end
    end
  end
end
