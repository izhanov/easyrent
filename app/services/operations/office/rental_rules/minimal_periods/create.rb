# frozen_string_literal: true

module Operations
  module Office
    module RentalRules
      module MinimalPeriods
        class Create < Base
          def call(params)
            minimal_period = RentalRule::MinimalPeriod.new(params)

            if minimal_period.save!
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
