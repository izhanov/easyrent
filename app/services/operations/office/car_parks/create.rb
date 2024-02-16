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
          ActiveRecord::Base.transaction do
            car_park = CarPark.create!(normalized_params)
            car_park.create_price_range!(unit: "day")
            Success(car_park)
          end
        rescue ActiveRecord::RecordNotUnique
          Failure[:uniqueness_violation, I18n.t("dry_validation.errors.rules.car_park.name.uniqueness_violation")]
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
