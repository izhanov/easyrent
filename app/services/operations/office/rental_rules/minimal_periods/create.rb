# frozen_string_literal: true

module Operations
  module Office
    module RentalRules
      module MinimalPeriods
        class Create < Base
          def call(params)
            validated_params = yield validate(params)
            minimal_period = yield commit(validated_params.to_h)
            Success(minimal_period)
          end

          private

          def validate(params)
            validation = Validations::Office::RentalRules::MinimalPeriods::Create.new.call(params)
            validation.to_monad
              .or { |result| Failure[:validation_error, result.errors.to_h] }
          end

          def commit(params)
            minimal_period = RentalRule::MinimalPeriod.create!(params)
            Success(minimal_period)
          end
        end
      end
    end
  end
end
