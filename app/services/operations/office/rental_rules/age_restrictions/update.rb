# frozen_string_literal: true

module Operations
  module Office
    module RentalRules
      module AgeRestrictions
        class Update < Base
          def call(age_restriction, params)
            if age_restriction.update!(params)
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
