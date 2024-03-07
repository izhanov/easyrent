# frozen_string_literal: true

module Operations
  module Office
    module Cars
      class Release < Base
        def call(car, responsible)
          released_car = yield release(car, responsible)
          Success(released_car)
        end

        private

        def release(car, responsible)
          audit_as_user(responsible) do
            car.update!(status: "vacant")
          end
          Success(car.reload)
        end
      end
    end
  end
end
