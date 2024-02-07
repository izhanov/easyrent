# frozen_strin_literal: true

module Office
  module RentalRules
    class AgeRestrictionsController < BaseController
      before_action :find_age_restriction, only: %i[show edit update]

      def new
        @age_restriction = RentalRule::AgeRestriction.new
      end

      def create
        operation = Operations::Office::RentalRules::AgeRestrictions::Create.new
        result = operation.call(age_restriction_params.to_h)

        case result
        in Success[age_restriction]
          @age_restriction = age_restriction
          respond_to do |format|
            format.html
            format.turbo_stream
          end
        in Failure[error_code, errors]
          @age_restriction = RentalRule::AgeRestriction.new(age_restriction_params)
          render :new, status: :unprocessable_entity
        end
      end

      def show
      end

      def edit
      end

      def update
        operation = Operations::Office::RentalRules::AgeRestrictions::Update.new
        result = operation.call(@age_restriction, age_restriction_params.to_h)

        case result
        in Success[age_restriction]
          @age_restriction = age_restriction
          respond_to do |format|
            format.html
            format.turbo_stream
          end
        in Failure[error_code, errors]
          render :edit, status: :unprocessable_entity
        end
      end

      private

      def age_restriction_params
        params.require(:rental_rule_age_restriction).permit(:owner_id, :owner_type, :value)
      end

      def find_age_restriction
        @age_restriction ||= @car_park.age_restriction
      end
    end
  end
end
