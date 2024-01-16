# frozen_string_literal: true

module Validations
  module Office
    module Cars
      class Create < Base
        params do
          required(:ownerable_id).filled(:integer)
          required(:ownerable_type).filled(:string)
          required(:mark_id).filled(:integer)
          required(:year).filled(:integer)
          required(:engine_capacity).filled(:decimal)
          required(:engine_capacity_unit).filled(:string, included_in?: Car::ENGINE_CAPACITY_UNITS)
          required(:fuel).filled(:string, included_in?: Car::FUEL_TYPES)
          required(:plate_number).filled(:string)
          required(:klass).filled(:string, included_in?: Car::KLASS_TYPES)
          required(:transmission).filled(:string, included_in?: Car::TRANSMISSION_TYPES)
          required(:vin_code).filled(:string)
          required(:technical_certificate_number).filled(:string)
          required(:mileage).filled(:integer)
          required(:color).filled(:string)
          required(:number_of_seats).filled(:integer)
        end
      end
    end
  end
end
