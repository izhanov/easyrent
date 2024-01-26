# frozen_string_literal: true

module Operations
  module Office
    module RentalRules
      module DrivingExperiences
        class Create < Base
          def call(params)
            age_restriction = RentalRule::DrivingExperience.new(params)

            if age_restriction.save!
              Success(age_restriction)
            else
              Failure(:invalid_data, age_restriction.errors)
            end
          end
        end
      end
    end
  end
end
