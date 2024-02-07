# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Office::RentalRules::AgeRestrictions::Update do
  describe "#call" do
    context "when invalid params" do
      it "returns failure with validation errors" do
        age_restriction = create(:rental_rule_age_restriction, :owned_by_car_park)
        params = {
          id: age_restriction.id,
          value: nil
        }

        result = subject.call(age_restriction, params)
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
      it "updates age restriction" do
        age_restriction = create(:rental_rule_age_restriction, :owned_by_car_park)
        params = {
          id: age_restriction.id,
          value: 18
        }

        result = subject.call(age_restriction, params)
        expect(result).to be_success
        expect(result.value!).to be_a(RentalRule::AgeRestriction)
        expect(result.value!.value).to eq(18)
      end
    end
  end
end
