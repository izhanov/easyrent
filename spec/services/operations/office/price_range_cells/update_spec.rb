# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Office::PriceRangeCells::Update do
  describe "#call" do
    context "when params are valid" do
      it "returns success with updated price range cell" do
        price_range = create(:price_range, :owned_by_car_park, unit: "day")
        price_range_cell = create(:price_range_cell, price_range: price_range, from: 1, to: 4)
        params = {
          from: 1,
          to: 2
        }

        result = subject.call(price_range_cell, params)
        expect(result).to be_success
        expect(result.value!).to be_a(PriceRangeCell)
        expect(result.value!.from).to eq(1)
        expect(result.value!.to).to eq(2)
      end
    end

    context "when params are invalid" do
      it "returns failure with validation errors" do
        price_range = create(:price_range, :owned_by_car_park, unit: "day")
        price_range_cell = create(:price_range_cell, price_range: price_range, from: 1, to: 4)
        params = {
          from: nil,
          to: nil
        }

        result = subject.call(price_range_cell, params)
        expect(result).to be_failure
        expect(result.failure).to match_array(
          [
            :validation_error,
            {
              from: ["is missing"],
              to: ["is missing"]
            }
          ]
        )
      end
    end
  end
end
