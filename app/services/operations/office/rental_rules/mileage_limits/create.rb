# frozen_string_literal: true

module Operations
  module Office
    module RentalRules
      module MileageLimits
        class Create < Base
          def call(params)
            validated_params = yield validate(params)
            mileage_limit = yield commit(validated_params.to_h)
            Success(mileage_limit)
          end

          private

          def validate(params)
            validation = Validations::Office::RentalRules::MileageLimits::Create.new.call(params)
            validation.to_monad
              .or { |failure| Failure[:validation_error, failure.errors.to_h]}
          end

          def commit(params)
            mileage_limit = RentalRule::MileageLimit.create!(params)
            Success(mileage_limit)
          end
        end
      end
    end
  end
end
