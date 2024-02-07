# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Office::PriceRanges::Update do
  describe "#call" do
    context "when params invalid" do
      it "returns failure with validation errors" do
        price_range = create(:price_range, :owned_by_car_park)
        params = {
          unit: "jjo"
        }

        result = subject.call(price_range, params)
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

    context "when params valid" do
      it "returns success with updated price range" do
        price_range = create(:price_range, :owned_by_car_park)
        params = {
          unit: "day"
        }

        result = subject.call(price_range, params)
        expect(result).to be_success
        expect(result.value!).to be_a(PriceRange)
        expect(result.value!.unit).to eq("day")
      end
    end
  end
end
