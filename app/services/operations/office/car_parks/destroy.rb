# frozen_string_literal: true

module Operations
  module Office
    module CarParks
      class Destroy < Base
        def call(car_park)
          car_park.destroy!
          Success(true)
        end
      end
    end
  end
end
