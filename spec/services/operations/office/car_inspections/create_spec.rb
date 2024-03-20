# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Office::CarInspections::Create do
  describe "#call" do
    context "when the params are valid" do
      it "creates a car inspection" do
        car = create(:car, :belongs_to_car_park)
        responsible = create(:user)

        params = {
          car_id: car.id,
          start_at: Date.current,
          end_at: Date.current + 1.day
        }

        result = subject.call(car, params, responsible)

        expect(result).to be_success
        expect(result.value!).to be_a(CarInspection)
      end
    end

    context "when the params are invalid" do
      it "returns a validation error" do
        car = create(:car, :belongs_to_car_park)
        responsible = create(:user)

        params = {
          car_id: car.id,
          start_at: nil,
          end_at: nil
        }

        result = subject.call(car, params, responsible)

        expect(result).to be_failure
        expect(result.failure).to match_array([:validation_error, {start_at: ["is missing"], end_at: ["is missing"]}])
      end
    end
  end
end
