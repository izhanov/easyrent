# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Office::Bookings::EndTheRent do
  describe "#call" do
    it "returns booking with status `end_the_rent`" do
      user = create(:user)
      car_park = create(:car_park)
      car = create(:car, owner: car_park)
      offer = create(:offer, car: car)
      booking = create(:booking, car: car, offer: offer)

      result = subject.call(booking, user)
      booking = result.value!
      expect(result).to be_success
      expect(booking.status).to eq("end_the_rent")
    end
  end
end
