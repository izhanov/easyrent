# frozen_string_literal: true

require "rails_helper"

RSpec.describe Utils::Bookings::Calculator do
  describe "#run" do
    context "when booked days count in price ranges cells" do
      it "returns price for rent period" do
        car_park = create(:car_park)
        car = create(:car, owner: car_park)
        offer = create(:offer, car: car, prices: {"1..3" => 100, "4..7" => 200}, pledge_amount: 100)
        booking = create(
          :booking,
          starts_at: Time.current,
          ends_at: 3.days.from_now,
          car: car,
          offer: offer
        )

        calculator = described_class.new(booking)
        result = calculator.run
        expect(result).to eq(900)
      end
    end

    context "booked days count out of price ranges cells" do
      it "returns price for rent period in the cells of the last price ranges" do
        car_park = create(:car_park)
        car = create(:car, owner: car_park)
        offer = create(:offer, car: car, prices: {"1..3" => 100, "4..7" => 200}, pledge_amount: 100)
        booking = create(
          :booking,
          starts_at: Time.current,
          ends_at: 9.days.from_now,
          car: car,
          offer: offer
        )

        calculator = described_class.new(booking)
        result = calculator.run

        expect(result).to eq(2100)
      end
    end
  end
end
