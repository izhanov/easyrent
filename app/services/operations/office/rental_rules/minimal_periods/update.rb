# frozen_string_literal: true

module Operations
  module Office
    module RentalRules
      module MinimalPeriods
        class Update < Base
          def call(minimal_period, params)
            if minimal_period.update!(params)
              Success(minimal_period)
            else
              Failure(:invalid_data, minimal_period.errors)
            end
          end
        end
      end
    end
  end
end
