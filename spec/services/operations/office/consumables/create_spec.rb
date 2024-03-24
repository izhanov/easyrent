# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Office::Consumables::Create do
  describe "#call" do
    context "when params are valid" do
      it "returns success with consumable" do
        car = create(:car, :belongs_to_car_park)
        consumable_params = attributes_for(:consumable, car_id: car.id)
        user = create(:user)

        result = subject.call(consumable_params, user)
        consumable = result.value!

        expect(result).to be_success
        expect(consumable).to be_a(Consumable)
        expect(consumable.title).to eq(consumable_params[:title])
        expect(consumable.description).to eq(consumable_params[:description])
        expect(consumable.lifetime).to eq(consumable_params[:lifetime])
        expect(consumable.car_id).to eq(consumable_params[:car_id])
      end
    end

    context "when params are invalid" do
      it "returns failure with errors" do
        car = create(:car, :belongs_to_car_park)
        consumable_params = attributes_for(:consumable, car_id: car.id, title: nil)
        user = create(:user)

        result = subject.call(consumable_params, user)
        errors = result.failure

        expect(result).to be_failure
        expect(errors).to match_array(
          [
            :validation_error,
            {
              title: ["is missing"]
            }
          ]
        )
      end
    end
  end
end
