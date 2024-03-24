# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Office::ConsumableLogs::Destroy do
  describe "#call" do
    it "destroys consumable_log" do
      car = create(:car, :belongs_to_car_park)
      consumable = create(:consumable, car: car)
      consumable_log = create(:consumable_log, consumable: consumable)
      user = create(:user)

      result = subject.call(consumable_log, user)

      expect(result).to be_success
      expect { consumable_log.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
