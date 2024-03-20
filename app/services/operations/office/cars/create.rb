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
          car_validation = Validations::Office::Cars::Create.new.call(params).to_monad
          insurance_validation = Validations::Office::CarInsurances::Create.new.call(params[:insurances_attributes]).to_monad
          car_inspetion_validation = Validations::Office::CarInspections::Create.new.call(params[:car_inspections_attributes]).to_monad

          case [car_validation, insurance_validation, car_inspetion_validation]
          in [Success => car_result, Success => insurance_result, Success => car_inspetion_result]
            Success(
              params.merge(
                insurances_attributes: [insurance_result.value!.to_h],
                car_inspections_attributes: [car_inspetion_result.value!.to_h]
              )
            )
          in [Failure => car_result, Failure => insurance_result, Failure => car_inspetion_result]
            Failure[
              :validation_error,
              car_result.failure.errors.to_h.merge(
                insurances_attributes: insurance_result.failure.errors.to_h,
                car_inspections_attributes: car_inspetion_result.failure.errors.to_h
              )
            ]
          in [Failure => car_result, Success, Success]
            Failure[:validation_error, car_result.failure.errors.to_h, Success]
          in [Failure => car_result, Success, Failure => car_inspetion_result]
            Failure[
              :validation_error,
              car_result.failure.errors.to_h.merge(
                car_inspections_attributes: car_inspetion_result.failure.errors.to_h
              )
            ]
          in [Success, Failure => insurance_result, Success]
            Failure[
              :validation_error,
              {
                insurance_attributes: insurance_result.failure.errors.to_h
              }
            ]
          in [Success, Success, Failure => car_inspetion_result]
            Failure[
              :validation_error,
              {
                car_inspections_attributes: car_inspetion_result.failure.errors.to_h
              }
            ]
          end
        end

        def commit(params)
          car = Car.create!(params)
          Success(car)
        rescue ActiveRecord::RecordNotUnique
          errors = {plate_number_or_vin_code: [I18n.t("dry_validation.errors.rules.car.plate_number_or_vin_code.uniqueness_violation")]}
          Failure[:uniqueness_violation, errors]
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
