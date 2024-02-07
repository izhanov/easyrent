# frozen_string_literal: true

module Office
  module RentalRules
    class BaseController < Office::BaseController
      before_action :find_car_park

      private

      def find_car_park
        @car_park ||= current_office_user.car_parks.find(params[:car_park_id])
      end
    end
  end
end
