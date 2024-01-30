# frozen_string_literal: true

module Operations
  module Office
    module RentalRules
      module AgeRestrictions
        class Create < Base
          def call(params)
            validated_params = yield validate(params)
            age_restriction = yield commit(validated_params.to_h)
            Success(age_restriction)
          end

          private

          def validate(params)
            validation = Validations::Office::RentalRules::AgeRestrictions::Create.new.call(params)
            validation.to_monad
              .or { |result| Failure[:validation_error, result.errors.to_h] }
          end

          def commit(params)
            age_restriction = RentalRule::AgeRestriction.create!(params)
            Success(age_restriction)
          end
        end
      end
    end
  end
end
