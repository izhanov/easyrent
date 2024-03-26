# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Office::Cars::Update do
  describe "#call" do
    context "when params is invalid" do
      it "returns failure" do
        car = create(:car, :belongs_to_car_park)
        params = {
          plate_number: "",
          color: "orange",
          engine_capacity: car.engine_capacity,
          technical_certificate_number: car.technical_certificate_number,
          transmission: car.transmission,
          year: car.year,
          engine_capacity_unit: car.engine_capacity_unit,
          vin_code: car.vin_code,
          fuel: car.fuel,
          klass: car.klass,
          mileage: car.mileage,
          number_of_seats: 4,
          tank_volume: car.tank_volume,
          over_mileage_price: 0.5e2,
        }

        result = subject.call(car, params)
        expect(result).to be_failure

        expect(result.failure).to(
          match_array(
            [
              :validation_error,
              {
                plate_number: ["is missing"],
                car_inspections_attributes: {
                  car_id: ["is missing"],
                  end_at: ["is missing"],
                  start_at: ["is missing"]
                },
                insurances_attributes: {
                  car_id: ["is missing"],
                  kind: ["is missing"],
                  start_at: ["is missing"],
                  end_at: ["is missing"]
                }
              }
            ]
          )
        )
      end
    end

    context "when params is valid" do
      it "returns success" do
        car = create(:car, :belongs_to_car_park)
        params = {
          plate_number: "666BOP02",
          color: "orange",
          engine_capacity: car.engine_capacity,
          technical_certificate_number: car.technical_certificate_number,
          transmission: car.transmission,
          year: car.year,
          engine_capacity_unit: car.engine_capacity_unit,
          vin_code: car.vin_code,
          fuel: car.fuel,
          klass: car.klass,
          mileage: car.mileage,
          number_of_seats: 4,
          tank_volume: car.tank_volume,
          over_mileage_price: 0.6e2,
          insurances_attributes: {
            car_id: car.id,
            kind: "ogpo",
            start_at: Date.new(2024, 3, 26),
            end_at: Date.new(2025, 3, 25)
          },
          car_inspections_attributes: {
            car_id: car.id,
            start_at: Date.new(2024, 3, 26),
            end_at: Date.new(2025, 3, 25)
          }
        }

        result = subject.call(car, params)
        updated_car = result.value!

        expect(result).to be_success
        expect(updated_car.plate_number).to eq("666BOP02")
      end
    end
  end
end
