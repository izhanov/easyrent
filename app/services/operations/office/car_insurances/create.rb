# frozen_string_literal: true

module Operations
  module Office
    module CarInsurances
      class Create < Base
        def call(car, params, responsible)
          validated_params = yield validate(params)
          car_insurance = yield commit(car, validated_params.to_h, responsible)
          Success(car_insurance)
        end

        private

        def validate(params)
          validation = Validations::Office::CarInsurances::Create.new.call(params)
          validation.to_monad
            .or { |failure| Failure[:validation_error, failure.errors.to_h] }
        end

        def commit(car, params, responsible)
          audit_as_user(responsible) do
            car_insurance = car.insurances.create!(params)
            Success(car_insurance)
          end
        end
      end
    end
  end
end
