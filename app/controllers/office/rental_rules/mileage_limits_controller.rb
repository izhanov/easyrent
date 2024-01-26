# frozen_string_literal: true

module Office
  module RentalRules
    class MileageLimitsController < BaseController
      before_action :find_mileage_limit, only: %i[show edit update destroy]

      def index
        @mileage_limits = @car_park.mileage_limits
      end

      def new
        @mileage_limit = RentalRule::MileageLimit.new
      end

      def create
        operation = Operations::Office::RentalRules::MileageLimits::Create.new
        result = operation.call(mileage_limit_params.to_h)

        case result
        in Success[mileage_limit]
          @mileage_limit = mileage_limit
          respond_to do |format|
            format.html
            format.turbo_stream
          end
        in Failure[error_code, errors]
          @mileage_limit = RentalRule::MileageLimit.new(mileage_limit_params)
          render :new, status: :unprocessable_entity
        end
      end

      def show
      end

      def edit
      end

      def update
        operation = Operations::Office::RentalRules::MileageLimits::Update.new
        result = operation.call(@mileage_limit, mileage_limit_params.to_h)

        case result
        in Success[mileage_limit]
          @mileage_limit = mileage_limit
          respond_to do |format|
            format.html
            format.turbo_stream { flash.now[:success] = "success" }
          end
        in Failure[error_code, errors]
          render :edit, status: :unprocessable_entity
        end
      end

      def destroy
        operation = Operations::Office::RentalRules::MileageLimits::Destroy.new
        result = operation.call(@mileage_limit)

        case result
        in Success
          respond_to do |format|
            format.html
            format.turbo_stream
          end
        in Failure[error_code, errors]
          render :edit, status: :unprocessable_entity
        end
      end

      private

      def find_mileage_limit
        @mileage_limit = @car_park.mileage_limits.find(params[:id])
      end

      def mileage_limit_params
        params.require(:rental_rule_mileage_limit).permit(
          :title,
          :value,
          :owner_id,
          :owner_type,
          :markup,
          :discount,
          :over_mileage_price
        )
      end
    end
  end
end
