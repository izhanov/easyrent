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
          required(:engine_capacity).value(:decimal)
          required(:engine_capacity_unit).value(:string)
          required(:fuel).filled(:string, included_in?: Car::FUEL_TYPES)
          required(:plate_number).filled(:string)
          required(:klass).filled(:string, included_in?: Car::KLASS_TYPES)
          required(:transmission).filled(:string, included_in?: Car::TRANSMISSION_TYPES)
          required(:vin_code).filled(:string)
          required(:technical_certificate_number).filled(:string)
          required(:mileage).filled(:integer, gt?: 0)
          required(:color).filled(:string)
          required(:number_of_seats).filled(:integer, gt?: 0)
          required(:tank_volume).value(:integer)
          required(:over_mileage_price).filled(:decimal, gt?: 0)
          optional(:photos_attributes).value(:hash)
        end

        rule(:engine_capacity, :fuel) do
          key.failure(:gt?) unless values[:fuel] == "electric"
        end

        rule(:tank_volume, :fuel) do
          key.failure(:gt?) unless values[:fuel] == "electric"
        end
      end
    end
  end
end
