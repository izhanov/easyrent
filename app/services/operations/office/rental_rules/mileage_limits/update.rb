# frozen_string_literal: true

module Operations
  module Office
    module RentalRules
      module MileageLimits
        class Update < Base
          def call(mileage_limit, params)
            validated_params = yield validate(params)
            updated_mileagelimit = yield commit(mileage_limit, validated_params.to_h)
            Success(updated_mileagelimit)
          end

          private

          def validate(params)
            validation = Validations::Office::RentalRules::MileageLimits::Update.new.call(params)
            validation.to_monad
              .or { |failure| Failure[:validation_error, failure.errors.to_h]}
          end

          def commit(mileage_limit, params)
            mileage_limit.update!(params)
            updated_mileagelimit = mileage_limit.reload
            Success(updated_mileagelimit)
          end
        end
      end
    end
  end
end
