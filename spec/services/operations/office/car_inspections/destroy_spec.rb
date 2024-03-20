# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Office::CarInspections::Destroy do
  describe "#call" do
    it "destroys the car inspection" do
      car = create(:car, :belongs_to_car_park)
      car_inspection = create(:car_inspection, car: car)

      result = subject.call(car_inspection)

      expect(result).to be_success
      expect(result.value!).to eq(true)
      expect { car_inspection.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
