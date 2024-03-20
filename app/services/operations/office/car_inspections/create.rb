# frozen_string_literal: true

module Operations
  module Office
    module CarInspections
      class Create < Base
        def call(car, params, responsible)
          validated_params = yield validate(params)
          car_inspection = yield commit(car, validated_params.to_h, responsible)
          Success(car_inspection)
        end

        private

        def validate(params)
          validation = Validations::Office::CarInspections::Create.new.call(params)
          validation.to_monad
            .or { |failure| Failure[:validation_error, failure.errors.to_h] }
        end

        def commit(car, params, responsible)
          audit_as_user(responsible) do
            car_inspection = car.car_inspections.create!(params)
            Success(car_inspection)
          end
        end
      end
    end
  end
end
