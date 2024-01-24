# frozen_string_literal: true

module Operations
  module Office
    module Cars
      class Create < Base
        def call(params)
          params = normalize_numbers(params)
          validated_params = yield validate(params)
          car = yield commit(validated_params.to_h)
          Success(car)
        end

        private

        def validate(params)
          validation = Validations::Office::Cars::Create.new.call(params)
          validation.to_monad
            .or { |result| Failure[:validation_error, result.errors.to_h] }
        end

        def commit(params)
          car = Car.create!(params)
          Success(car)
        rescue ActiveRecord::RecordNotUnique => e

          errors = {title: [I18n.t("dry_validation.errors.rules.car.title.uniqueness_violation")]}
          Failure[:uniqueness_violation, errors]
        end

        def normalize_numbers(params)
          %w[year mileage number_of_seats tank_volume engine_capacity].each do |key|
            if params.key?(key)
              params[key] = params[key].to_s.gsub(/[^0-9]/, "").to_f
            end
          end
          params
        end
      end
    end
  end
end
