# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Office::Consumables::Destroy do
  describe "#call" do
    it "destroys consumable" do
      car = create(:car, :belongs_to_car_park)
      consumable = create(:consumable, car: car)
      user = create(:user)

      result = subject.call(consumable, user)

      expect(result).to be_success
      expect { consumable.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
