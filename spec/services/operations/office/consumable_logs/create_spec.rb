# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Office::ConsumableLogs::Create do
  describe "#call" do
    context "when params are valid" do
      it "returns success with consumable_log" do
        car = create(:car, :belongs_to_car_park)
        consumable = create(:consumable, car: car)
        user = create(:user)

        consumable_log_params = attributes_for(
          :consumable_log,
          description: "new description",
          consumable_id: consumable.id
        )

        result = subject.call(consumable_log_params, user)
        consumable_log = result.value!

        expect(result).to be_success
        expect(consumable_log).to be_a(ConsumableLog)
        expect(consumable_log.description).to eq(consumable_log_params[:description])
        expect(consumable_log.consumable_id).to eq(consumable_log_params[:consumable_id])
      end
    end

    context "when params are invalid" do
      it "returns failure with errors" do
        car = create(:car, :belongs_to_car_park)
        consumable = create(:consumable, car: car)
        user = create(:user)

        consumable_log_params = attributes_for(
          :consumable_log,
          description: nil,
          consumable_id: consumable.id,
          date: ""
        )

        result = subject.call(consumable_log_params, user)
        errors = result.failure

        expect(result).to be_failure
        expect(errors).to match_array(
          [
            :validation_error,
            {
              description: ["must be a string"],
              date: ["is missing"]
            }
          ]
        )
      end
    end
  end
end
