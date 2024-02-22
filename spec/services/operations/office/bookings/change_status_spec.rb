# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Office::Bookings::ChangeStatus do
  describe "#call" do
    context "when status is invalid" do
      it "returns failure" do
        car_park = create(:car_park)
        car = create(:car, owner: car_park)
        offer = create(:offer, car: car)
        booking = create(:booking, car: car, offer: offer)

        status = "invalid_status"

        result = described_class.new.call(booking, status)

        expect(result).to be_failure
        expect(result.failure).to match_array(
          [
            :validation_error,
            {status: ["Invalid status"]}
          ]
        )
      end
    end

    context "when status valid" do
      it "returns success with updated booking" do
        car_park = create(:car_park)
        car = create(:car, owner: car_park)
        offer = create(:offer, car: car)
        booking = create(:booking, car: car, offer: offer)

        status = "confirmed"

        result = described_class.new.call(booking, status)

        expect(result).to be_success
        expect(result.value!).to eq(booking.reload)
      end
    end
  end
end
