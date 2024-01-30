# frozen_string_literal: true

module Office
  module RentalRules
    class DrivingExperiencesController < BaseController
      before_action :find_driving_experience, only: %i[show edit update]

      def new
        @driving_experience = RentalRule::DrivingExperience.new
      end

      def create
        operation = Operations::Office::RentalRules::DrivingExperiences::Create.new
        result = operation.call(driving_experience_params.to_h)

        case result
        in Success[driving_experience]
          @driving_experience = driving_experience
          respond_to do |format|
            format.html
            format.turbo_stream
          end
        in Failure[error_code, errors]
          @driving_experience = RentalRule::DrivingExperience.new(driving_experience_params)
          render :new, status: :unprocessable_entity
        end
      end

      def show
      end

      def edit
      end

      def update
        operation = Operations::Office::RentalRules::DrivingExperiences::Update.new
        result = operation.call(@driving_experience, driving_experience_params.to_h)

        case result
        in Success[driving_experience]
          @driving_experience = driving_experience
          respond_to do |format|
            format.html
            format.turbo_stream
          end
        in Failure[error_code, errors]
          render :edit, status: :unprocessable_entity
        end
      end

      private

      def find_driving_experience
        @driving_experience ||= @car_park.driving_experience
      end

      def driving_experience_params
        params.require(:rental_rule_driving_experience).permit(
          :owner_id, :owner_type, :value
        )
      end
    end
  end
end
