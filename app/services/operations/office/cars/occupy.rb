# frozen_string_literal: true

module Operations
  module Office
    module Cars
      class Occupy < Base
        def call(car, responsible)
          occupied_car = yield occupy(car, responsible)
          Success(occupied_car)
        end

        private

        def occupy(car, responsible)
          audit_as_user(responsible) do
            car.update!(status: "occupied")
          end
          Success(car.reload)
        end
      end
    end
  end
end
