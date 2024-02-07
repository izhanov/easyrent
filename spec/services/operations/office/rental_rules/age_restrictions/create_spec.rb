# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Office::RentalRules::AgeRestrictions::Create do
  describe "#call" do
    context "when invalid params" do
      it "returns failure with validation errors" do
        car_park = create(:car_park)
        params = {
          owner_id: car_park.id,
          owner_type: "CarPark",
          value: nil
        }

        result = subject.call(params)
        expect(result).to be_failure
        expect(result.failure).to match_array(
          [
            :validation_error,
            {
              value: ["is missing"]
            }
          ]
        )
      end
    end

    context "when valid params" do
      it "creates age restriction" do
        car_park = create(:car_park)
        params = {
          owner_id: car_park.id,
          owner_type: "CarPark",
          value: 18
        }

        result = subject.call(params)
        expect(result).to be_success
        expect(result.value!).to be_a(RentalRule::AgeRestriction)
        expect(result.value!.owner).to eq(car_park)
      end
    end
  end
end
