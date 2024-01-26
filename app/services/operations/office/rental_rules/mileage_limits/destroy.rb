# frozen_string_literal: true

module Operations
  module Office
    module RentalRules
      module MileageLimits
        class Destroy < Base
          def call(mileage_limit)
            mileage_limit.destroy!
            Success(true)
          end
        end
      end
    end
  end
end
