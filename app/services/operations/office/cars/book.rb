# frozen_string_literal: true

module Operations
  module Office
    module Cars
      class Book < Base
        def call(car, responsible)
          booked_car = yield book(car, responsible)
          Success(booked_car)
        end

        private

        def book(car, responsible)
          audit_as_user(responsible) do
            car.update!(status: "booked")
          end
          Success(car.reload)
        end
      end
    end
  end
end
