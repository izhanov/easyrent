# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Office::Consumables::Update do
  describe "#call" do
    context "when params are valid" do
      it "returns success with consumable" do
        car = create(:car, :belongs_to_car_park)
        consumable = create(:consumable, car: car)
        user = create(:user)

        consumable_params = attributes_for(
          :consumable,
          title: "new title",
          description: "new description",
          lifetime: 100,
          car_id: car.id
        )

        result = subject.call(consumable, consumable_params, user)
        updated_consumable = result.value!

        expect(result).to be_success
        expect(updated_consumable).to be_a(Consumable)
        expect(updated_consumable.title).to eq(consumable_params[:title])
        expect(updated_consumable.description).to eq(consumable_params[:description])
        expect(updated_consumable.lifetime).to eq(consumable_params[:lifetime])
        expect(updated_consumable.car_id).to eq(consumable_params[:car_id])
      end
    end

    context "when params are invalid" do
      it "returns failure with errors" do
        car = create(:car, :belongs_to_car_park)
        consumable = create(:consumable, car: car)
        user = create(:user)

        consumable_params = attributes_for(
          :consumable,
          title: nil,
          description: "new description",
          lifetime: 100,
          car_id: car.id
        )

        result = subject.call(consumable, consumable_params, user)
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
