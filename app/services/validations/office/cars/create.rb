# frozen_string_literal: true

module Validations
  module Office
    module Cars
      class Create < Base
        params do
          required(:owner_id).filled(:integer)
          required(:owner_type).filled(:string)
          required(:mark_id).filled(:integer)
          required(:year).filled(:integer, gt?: 1920)
          required(:engine_capacity).filled(:decimal, gt?: 0)
          required(:engine_capacity_unit).filled(:string, included_in?: Car::ENGINE_CAPACITY_UNITS)
          required(:fuel).filled(:string, included_in?: Car::FUEL_TYPES)
          required(:plate_number).filled(:string)
          required(:klass).filled(:string, included_in?: Car::KLASS_TYPES)
          required(:transmission).filled(:string, included_in?: Car::TRANSMISSION_TYPES)
          required(:vin_code).filled(:string)
          required(:technical_certificate_number).filled(:string)
          required(:mileage).filled(:integer, gt?: 0)
          required(:color).filled(:string)
          required(:number_of_seats).filled(:integer, gt?: 0)
          required(:tank_volume).filled(:integer, gt?: 0)
          required(:photos_attributes).filled(:array)
        end
      end
    end
  end
end
