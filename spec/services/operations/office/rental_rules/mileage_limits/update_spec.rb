# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Office::RentalRules::MileageLimits::Update do
  describe "#call" do
    context "when invalid params" do
      it "returns failure with validation errors" do
        mileage_limit = create(:rental_rule_mileage_limit, :owned_by_car_park)
        params = {
          id: mileage_limit.id,
          value: nil,
          title: mileage_limit.title
        }

        result = subject.call(mileage_limit, params)
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
      it "updates mileage limit" do
        mileage_limit = create(:rental_rule_mileage_limit, :owned_by_car_park)
        params = {
          id: mileage_limit.id,
          value: 100,
          title: mileage_limit.title
        }

        result = subject.call(mileage_limit, params)
        expect(result).to be_success
        expect(result.value!).to be_a(RentalRule::MileageLimit)
        expect(result.value!.value).to eq(100)
      end
    end
  end
end
