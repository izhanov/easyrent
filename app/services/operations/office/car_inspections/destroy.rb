# frozen_string_literal: true

module Operations
  module Office
    module CarInspections
      class Destroy < Base
        def call(car_inspection)
          yield commit(car_inspection)
          Success(true)
        end

        private

        def commit(car_inspection)
          car_inspection.destroy!
          Success(true)
        end
      end
    end
  end
end
