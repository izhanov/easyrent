# frozen_string_literal: true

module Operations
  module Office
    module RentalRules
      module AgeRestrictions
        class Update < Base
          def call(age_restriction, params)
            validated_params = yield validate(params)
            updated_age_restriction = yield commit(age_restriction, validated_params.to_h)
            Success(updated_age_restriction)
          end

          private

          def validate(params)
            validation = Validations::Office::RentalRules::AgeRestrictions::Update.new.call(params)
            validation.to_monad
              .or { |result| Failure[:validation_error, result.errors.to_h] }
          end

          def commit(age_restriction, params)
            age_restriction.update!(params)
            Success(age_restriction.reload)
          end
        end
      end
    end
  end
end
