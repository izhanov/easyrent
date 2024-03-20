# frozen_string_literal: true

module Operations
  module Office
    module CarInspections
      class Update < Base
        def call(car_inspection, params, responsible)
          validated_params = yield validate(params)
          updated_car_inspection = yield commit(car_inspection, validated_params.to_h, responsible)
          Success(updated_car_inspection)
        end

        private

        def validate(params)
          validation = Validations::Office::CarInspections::Update.new.call(params)
          validation.to_monad
            .or { |failure| Failure[:validation_error, failure.errors.to_h] }
        end

        def commit(car_inspection, params, responsible)
          audit_as_user(responsible) do
            car_inspection.update!(params)
            Success(car_inspection.reload)
          end
        end
      end
    end
  end
end
