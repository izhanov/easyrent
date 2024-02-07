# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Office::PriceRanges::Create do
  describe "#call" do
    context "when params are valid" do
      it "creates price range" do
        car_park = create(:car_park)
        params = {
          owner_id: car_park.id,
          owner_type: "CarPark",
          unit: "day"
        }

        result = subject.call(params)
        expect(result).to be_success
        expect(result.value!).to be_a(PriceRange)
      end
    end

    context "when params are invalid" do
      it "returns failure with validation errors" do
        params = {
          owner_id: nil,
          owner_type: nil,
          unit: nil
        }

        result = subject.call(params)
        expect(result).to be_failure
        expect(result.failure).to match_array(
          [
            :validation_error,
            {
              owner_id: ["is missing"],
              owner_type: ["is missing"],
              unit: ["is missing"]
            }
          ]
        )
      end

      context "when unit is invalid" do
        it "returns failure with validation errors" do
          car_park = create(:car_park)
          params = {
            owner_id: car_park.id,
            owner_type: "CarPark",
            unit: "invalid"
          }

          result = subject.call(params)
          expect(result).to be_failure
          expect(result.failure).to match_array(
            [
              :validation_error,
              {
                unit: ["must be one of: day"]
              }
            ]
          )
        end
      end
    end
  end
end
