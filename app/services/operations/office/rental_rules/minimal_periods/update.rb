# frozen_string_literal: true

module Operations
  module Office
    module RentalRules
      module MinimalPeriods
        class Update < Base
          def call(minimal_period, params)
            validated_params = yield validate(params)
            updated_minimal_period = yield commit(minimal_period, validated_params.to_h)
            Success(updated_minimal_period)
          end

          private

          def validate(params)
            validation = Validations::Office::RentalRules::MinimalPeriods::Update.new.call(params)
            validation.to_monad
              .or { |result| Failure[:validation_error, result.errors.to_h] }
          end

          def commit(minimal_period, params)
            minimal_period.update!(params)
            Success(minimal_period.reload)
          end
        end
      end
    end
  end
end
