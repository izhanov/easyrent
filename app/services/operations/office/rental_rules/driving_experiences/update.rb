# frozen_string_literal: true

module Operations
  module Office
    module RentalRules
      module DrivingExperiences
        class Update < Base
          def call(driving_experience, params)
            if driving_experience.update!(params)
              Success(driving_experience)
            else
              Failure(:invalid_data, driving_experience.errors)
            end
          end
        end
      end
    end
  end
end
