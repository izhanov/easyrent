# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Office::Offers::Create do
  describe "#call" do
    context "when params are valid" do
      it "returns success with offer" do
        car = create(:car, :belongs_to_car_park)
        mileage_limit = create(:rental_rule_mileage_limit, owner: car.owner)

        params = {
          car_id: car.id,
          title: "Offer title",
          prices: {"1-4" => "100", "5-10" => "200"},
          services: {"delivery" => "100", "gps" => "200", "baby_seat" => "300"},
          mileage_limit_id: mileage_limit.id,
          pledge_amount: 150_000.00,
          published: true
        }
        result = subject.call(params)
        expect(result).to be_success
        expect(result.value!).to be_a(Offer)
      end
    end

    context "when params are invalid" do
      it "returns failure with validation errors" do
        car = create(:car, :belongs_to_car_park)
        params = {
          car_id: car.id,
          title: "Offer title with mega super long description",
          prices: nil,
          services: nil
        }
        result = subject.call(params)
        expect(result).to be_failure
        expect(result.failure).to match_array(
          [
            :validation_error,
            {
              title: ["size cannot be greater than 20 symbols"],
              prices: ["is missing"],
              mileage_limit_id: ["is missing"],
              published: ["is missing"],
              pledge_amount: ["is missing"]
            }
          ]
        )
      end
    end
  end
end
