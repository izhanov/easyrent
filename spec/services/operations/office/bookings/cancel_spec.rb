# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Office::Bookings::Cancel do
  describe "#call" do
    it "returns booking with status `cancelled`" do
      user = create(:user)
      car_park = create(:car_park)
      car = create(:car, owner: car_park)
      offer = create(:offer, car: car)
      booking = create(:booking, car: car, offer: offer)

      result = subject.call(booking, user)
      booking = result.value!
      expect(result).to be_success
      expect(booking.status).to eq("cancelled")
    end

    it "change change car's status to vacant" do
      user = create(:user)
      car_park = create(:car_park)
      car = create(:car, owner: car_park)
      offer = create(:offer, car: car)
      booking = create(:booking, car: car, offer: offer)

      result = subject.call(booking, user)
      booking = result.value!
      car = booking.car
      expect(car.status).to eq("vacant")
    end
  end
end
