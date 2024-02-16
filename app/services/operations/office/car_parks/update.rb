# frozen_string_literal: true

module Operations
  module Office
    module CarParks
      class Update < Base
        def call(car_park, params)
          validated_params = yield validate(params, kind: car_park.kind)
          car_park = yield commit(car_park, validated_params.to_h)
          Success(car_park)
        end

        private

        def validate(params, kind:)
          validation = "Validations::Office::CarParks::#{kind.capitalize}::Update".constantize.new
          validation.call(params).to_monad
            .or { |result| Failure[:validation_error, result.errors.to_h] }
        end

        def commit(car_park, params)
          normalized_params = normalize_phones(params)
          car_park.update!(normalized_params)
          Success(car_park)
        rescue ActiveRecord::RecordNotUnique
          Failure[:uniqueness_violation, {}]
        end

        def normalize_phones(params)
          params.each do |key, value|
            if key.to_s.match?(/_phone/)
              params[key] = value.gsub(/[^+\d]/, "")
            end
          end
          params
        end
      end
    end
  end
end
