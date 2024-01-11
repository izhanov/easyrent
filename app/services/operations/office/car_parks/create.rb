# frozen_string_literal: true

module Operations
  module Office
    module CarParks
      class Create < Base
        def call(params)
          validated_params = yield validate(params)
          car_park = yield commit(validated_params.to_h)
          Success(car_park)
        end

        private

        def validate(params)
          kind = params[:kind]
          validation = "Validations::Office::CarParks::#{kind.capitalize}::Create".constantize.new
          validation.call(params).to_monad
            .or { |result| Failure[:validation_error, result.errors.to_h] }
        end

        def commit(params)
          normalized_params = normalize_phones(params)
          car_park = CarPark.create!(normalized_params)
          Success(car_park)
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
