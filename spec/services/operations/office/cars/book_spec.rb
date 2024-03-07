# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Office::Cars::Book do
  describe "#call" do
    it "returns updated car with status `booked`" do
      user = create(:user)
      car = create(:car, :belongs_to_car_park)

      result = subject.call(car, user)
      updated_car = result.value!

      expect(updated_car.status).to eq("booked")
    end
  end
end
