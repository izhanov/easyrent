# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Office::RentalRules::MileageLimits::Create do
  describe "#call" do
    context "when invalid params" do
      it "returns failure with validation errors" do
        car_park = create(:car_park)
        params = {
          owner_id: car_park.id,
          owner_type: "CarPark",
          value: nil,
          over_mileage_price: nil,
          markup: nil,
          discount: nil
        }

        result = subject.call(params)
        expect(result).to be_failure
        expect(result.failure).to match_array(
          [
            :validation_error,
            {
              title: ["is missing"],
              value: ["is missing"],
              over_mileage_price: ["is missing"],
              markup: ["must be an integer"],
              discount: ["must be an integer"]
            }
          ]
        )
      end
    end

    context "when valid params" do
      it "creates mileage limit" do
        car_park = create(:car_park)
        params = {
          owner_id: car_park.id,
          owner_type: "CarPark",
          title: "Basic",
          value: 100,
          over_mileage_price: 70.0,
          markup: 0,
          discount: 0
        }

        result = subject.call(params)
        expect(result).to be_success
        expect(result.value!).to be_a(RentalRule::MileageLimit)
        expect(result.value!.owner).to eq(car_park)
      end
    end
  end
end
