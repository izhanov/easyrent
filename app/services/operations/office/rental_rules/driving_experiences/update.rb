# frozen_string_literal: true

module Operations
  module Office
    module RentalRules
      module DrivingExperiences
        class Update < Base
          def call(driving_experience, params)
            validated_params = yield validate(params)
            updated_driving_experience = yield commit(driving_experience, validated_params.to_h)
            Success(updated_driving_experience)
          end

          private

          def validate(params)
            validation = Validations::Office::RentalRules::DrivingExperiences::Update.new.call(params)
            validation.to_monad
              .or { |result| Failure[:validation_error, result.errors.to_h] }
          end

          def commit(driving_experience, params)
            driving_experience.update!(params)
            Success(driving_experience.reload)
          end
        end
      end
    end
  end
end
