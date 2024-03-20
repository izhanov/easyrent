# frozen_string_literal: true

module Operations
  module Office
    module CarInsurances
      class Update < Base
        def call(car_insurance, params, responsible)
          validated_params = yield validate(params)
          updated_car_insurance = yield commit(car_insurance, validated_params.to_h, responsible)
          Success(updated_car_insurance)
        end

        private

        def validate(params)
          validation = Validations::Office::CarInsurances::Update.new.call(params)
          validation.to_monad
            .or { |failure| Failure[:validation_error, failure.errors.to_h] }
        end

        def commit(car_insurance, params, responsible)
          audit_as_user(responsible) do
            car_insurance.update!(params)
            Success(car_insurance.reload)
          end
        end
      end
    end
  end
end
