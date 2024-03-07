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
          tank_volume: car.tank_volume
        }

        result = subject.call(car, params)
        expect(result).to be_failure
        expect(result.failure).to match_array([:validation_error, {plate_number: ["is missing"]}])
      end
    end
  end
end
