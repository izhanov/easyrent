# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Office::Cars::Create do
  describe "#call" do
    context "when params is invalid" do
      it "returns failure" do
        params = {
          mark_id: nil,
          year: "2023",
          fuel: "gasoline",
          klass_type: "economy",
          transmission_type: "automatic",
          car_park_id: "1"
        }

        result = subject.call(params)
        expect(result).to be_failure
      end
    end

    context "when params is valid" do
      it "returns success" do
        car_park = create(:car_park)
        mark = create(:mark)

        params = {
          owner_id: car_park.id,
          owner_type: "CarPark",
          mark_id: mark.id,
          year: 2023,
          fuel: "gas",
          klass: "economy",
          transmission: "automatic",
          vin_code: "12345678901234567",
          plate_number: "666BOP02",
          engine_capacity: 1.6,
          engine_capacity_unit: "l",
          color: "red",
          technical_certificate_number: "12345678901234567",
          mileage: 100_000,
          number_of_seats: 4,
          tank_volume: 50,
          photos_attributes: {},
          insurances_attributes: {
            kind: "ogpo",
            start_at: Date.current,
            end_at: Date.current + 1.year
          }
        }

        result = subject.call(params)
        expect(result).to be_success
      end
    end
  end
end
