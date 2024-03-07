# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Office::Cars::Release do
  describe "#call" do
    it "returns updated car with status `occupied`" do
      user = create(:user)
      car = create(:car, :belongs_to_car_park, :booked)

      result = subject.call(car, user)
      updated_car = result.value!

      expect(updated_car.status).to eq("vacant")
    end
  end
end
