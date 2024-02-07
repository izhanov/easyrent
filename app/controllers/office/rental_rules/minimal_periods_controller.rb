# frozen_string_literal: true

module Office
  module RentalRules
    class MinimalPeriodsController < BaseController
      before_action :find_minimal_period, only: %i[show edit update]

      def new
        @minimal_period = RentalRule::MinimalPeriod.new
      end

      def create
        operation = Operations::Office::RentalRules::MinimalPeriods::Create.new
        result = operation.call(minimal_period_params.to_h)

        case result
        in Success[minimal_period]
          @minimal_period = minimal_period
          respond_to do |format|
            format.html
            format.turbo_stream
          end
        in Failure[error_code, errors]
          @minimal_period = RentalRule::MinimalPeriod.new(minimal_period_params)
          render :new, status: :unprocessable_entity
        end
      end

      def show
      end

      def edit
      end

      def update
        operation = Operations::Office::RentalRules::MinimalPeriods::Update.new
        result = operation.call(@minimal_period, minimal_period_params.to_h)

        case result
        in Success[minimal_period]
          @minimal_period = minimal_period
          respond_to do |format|
            format.html
            format.turbo_stream
          end
        in Failure[error_code, errors]
          render :edit, status: :unprocessable_entity
        end
      end

      private

      def minimal_period_params
        params.require(:rental_rule_minimal_period).permit(:value, :owner_id, :owner_type)
      end

      def find_minimal_period
        @minimal_period = @car_park.minimal_period
      end
    end
  end
end
