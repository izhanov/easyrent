# frozen_string_literal: true

module Validations
  module Office
    module Cars
      class Update < Base
        params do
          required(:plate_number).filled(:string)
          required(:year).filled(:integer, gt?: 1920)
          required(:engine_capacity).value(:decimal)
          required(:engine_capacity_unit).value(:string)
          required(:fuel).filled(:string, included_in?: Car::FUEL_TYPES)
          required(:klass).filled(:string, included_in?: Car::KLASS_TYPES)
          required(:transmission).filled(:string, included_in?: Car::TRANSMISSION_TYPES)
          required(:vin_code).filled(:string)
          required(:technical_certificate_number).filled(:string)
          required(:mileage).filled(:integer, gt?: 0)
          required(:color).filled(:string)
          required(:number_of_seats).filled(:integer, gt?: 0)
          required(:tank_volume).filled(:integer, gt?: 0)
          required(:over_mileage_price).filled(:decimal, gt?: 0)
        end

        rule(:engine_capacity, :fuel) do
          unless values[:fuel] == "electric"
            key.failure(:gt?) if values[:engine_capacity].nil? || values[:engine_capacity] <= 0
          end
        end

        rule(:tank_volume, :fuel) do
          unless values[:fuel] == "electric"
            key.failure(:gt?) if values[:tank_volume].nil? || values[:tank_volume] <= 0
          end
        end
      end
    end
  end
end
