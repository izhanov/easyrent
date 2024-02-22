# frozen_string_literal: true

module Operations
  module Office
    module Cars
      class Update < Base
        def call(car, params)
          params = normalize_numbers(params)
          validated_params = yield validate(params)
          updated_car = yield commit(car, validated_params.to_h)
          Success(updated_car)
        end

        private

        def validate(params)
          validation = Validations::Office::Cars::Update.new.call(params)
          validation.to_monad
            .or { |failure| Failure[:validation_error, failure.errors.to_h] }
        end

        def commit(car, params)
          car.update!(params)
          Success(car.reload)
        end

        def normalize_numbers(params)
          %w[year mileage number_of_seats tank_volume engine_capacity].each do |key|
            if params.key?(key)
              params[key] = params[key].to_s.gsub(/[^0-9,.]/, "").to_f
            end
          end
          params
        end
      end
    end
  end
end
