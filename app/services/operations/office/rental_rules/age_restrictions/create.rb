# frozen_string_literal: true

module Operations
  module Office
    module RentalRules
      module AgeRestrictions
        class Create < Base
          def call(params)
            age_restriction = RentalRule::AgeRestriction.new(params)

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
