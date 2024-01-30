# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Office::RentalRules::DrivingExperiences::Update do
  describe "#call" do
    context "when invalid params" do
      it "returns failure with validation errors" do
        driving_experience = create(:rental_rule_driving_experience, :owned_by_car_park)
        params = {
          id: driving_experience.id,
          value: nil
        }

        result = subject.call(driving_experience, params)
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
      it "updates driving experience" do
        driving_experience = create(:rental_rule_driving_experience, :owned_by_car_park)
        params = {
          id: driving_experience.id,
          value: 18
        }

        result = subject.call(driving_experience, params)
        expect(result).to be_success
        expect(result.value!).to be_a(RentalRule::DrivingExperience)
        expect(result.value!.value).to eq(18)
      end
    end
  end
end
