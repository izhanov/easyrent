# frozen_string_literal: true

module Operations
  module Office
    module Cars
      class Inspect < Base
        def call(car_id, car_params, responsible_params)
          car = yield find_car(car_id)
          responsible = yield find_responsible(responsible_params)
          yield inspect(car, car_params, responsible)
          Success(car.reload)
        end

        private

        def find_car(car_id)
          car = Car.find(car_id)
          car ? Success(car) : Failure[:car_not_found, {car: ['not found']}]
        end

        def find_responsible(responsible_params)
          responsible_klass = responsible_params[:type].constantize
          responsible = responsible_klass.find(responsible_params[:id])
          Success(responsible)
        rescue ActiveRecord::RecordNotFound
          Failure[:responsible_not_found, {responsible: ['not found']}]
        end

        def inspect(car, params, responsible)
          audit_as_user(responsible) do
            car.update!(params)
          end
          Success(car)
        end
      end
    end
  end
end
