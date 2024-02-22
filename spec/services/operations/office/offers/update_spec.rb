# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Office::Offers::Update do
  describe "#call" do
    context "when params invalid" do
      it "returns failure with validation errors" do
        car = create(:car, :belongs_to_car_park)
        offer = create(:offer, car: car)
        params = {
          id: offer.id,
          title: "Offer title with mega super long description",
          prices: nil
        }
        result = subject.call(offer, params)
        expect(result).to be_failure
        expect(result.failure).to match_array(
          [
            :validation_error,
            {
              title: ["size cannot be greater than 20 symbols"],
              prices: ["is missing"],
              mileage_limit_id: ["is missing"],
              pledge_amount: ["is missing"]
            }
          ]
        )
      end
    end
  end
end
