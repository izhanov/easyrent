# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Office::Bookings::Confirm do
  describe "#call" do
    it "returns success with updated booking and booking's car's status is changed to booked" do
      user = create(:user)
      car_park = create(:car_park)
      car = create(:car, owner: car_park)
      offer = create(:offer, car: car)
      booking = create(:booking, car: car, offer: offer)

      result = described_class.new.call(booking, user)
      booking = result.value!

      expect(result).to be_success
      expect(booking.status).to eq("confirmed")
    end

    it "change car status to `occupied`" do
      user = create(:user)
      car_park = create(:car_park)
      car = create(:car, owner: car_park)
      offer = create(:offer, car: car)
      booking = create(:booking, car: car, offer: offer)

      result = described_class.new.call(booking, user)
      updated_booking = result.value!
      car = updated_booking.car

      expect(car.status).to eq("occupied")
    end
  end
end
