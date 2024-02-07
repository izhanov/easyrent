# frozen_string_literal: true

module Operations
  module Office
    module RentalRules
      module DrivingExperiences
        class Create < Base
          def call(params)
            validated_params = yield validate(params)
            driving_experience = yield commit(validated_params.to_h)
            Success(driving_experience)
          end

          private

          def validate(params)
            validation = Validations::Office::RentalRules::DrivingExperiences::Create.new.call(params)
            validation.to_monad
              .or { |result| Failure[:validation_error, result.errors.to_h] }
          end

          def commit(params)
            driving_experience = RentalRule::DrivingExperience.create!(params)
            Success(driving_experience)
          end
        end
      end
    end
  end
end
