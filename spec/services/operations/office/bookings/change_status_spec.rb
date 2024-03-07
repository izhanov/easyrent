# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Office::Bookings::ChangeStatus do
  describe "#call" do
    context "when status is invalid" do
      it "returns failure" do
        user = create(:user)
        car_park = create(:car_park)
        car = create(:car, owner: car_park)
        offer = create(:offer, car: car)
        booking = create(:booking, car: car, offer: offer)

        status = "invalid_status"

        result = described_class.new.call(booking, status, user)

        expect(result).to be_failure
        expect(result.failure).to match_array(
          [
            :validation_error,
            {status: ["Invalid status"]}
          ]
        )
      end
    end

    context "when status 'confirmed'" do
      it "returns success with updated booking" do
        user = create(:user)
        car_park = create(:car_park)
        car = create(:car, owner: car_park)
        offer = create(:offer, car: car)
        booking = create(:booking, car: car, offer: offer)

        status = "confirmed"

        result = described_class.new.call(booking, status, user)
        booking = result.value!

        expect(result).to be_success
        expect(booking.status).to eq("confirmed")
      end
    end

    context "when status 'give_out_the_car'" do
      it "returns success with updated booking" do
        user = create(:user)
        car_park = create(:car_park)
        car = create(:car, owner: car_park)
        offer = create(:offer, car: car)
        booking = create(:booking, :payment_accepted, car: car, offer: offer)

        status = "give_out_the_car"

        result = described_class.new.call(booking, status, user)
        booking = result.value!
        expect(result).to be_success
        expect(booking.status).to eq("give_out_the_car")
      end
    end

    context "when status 'start_the_rent'" do
      it "returns success with updated booking" do
        user = create(:user)
        car_park = create(:car_park)
        car = create(:car, owner: car_park)
        offer = create(:offer, car: car)
        booking = create(:booking, :give_out_the_car, car: car, offer: offer)

        status = "start_the_rent"

        result = described_class.new.call(booking, status, user)
        booking = result.value!
        expect(result).to be_success
        expect(booking.status).to eq("start_the_rent")
      end
    end

    context "when status 'accept_the_car'" do
      it "returns success with updated booking" do
        user = create(:user)
        car_park = create(:car_park)
        car = create(:car, owner: car_park)
        offer = create(:offer, car: car)
        booking = create(:booking, :car_in_rent, car: car, offer: offer)

        status = "accept_the_car"

        result = described_class.new.call(booking, status, user)
        booking = result.value!
        expect(result).to be_success
        expect(booking.status).to eq("accept_the_car")
      end
    end

    context "when status 'return_the_deposit'" do
      it "returns success with updated booking" do
        user = create(:user)
        car_park = create(:car_park)
        car = create(:car, owner: car_park)
        offer = create(:offer, car: car)
        booking = create(:booking, :accept_the_car, car: car, offer: offer)

        status = "return_the_deposit"

        result = described_class.new.call(booking, status, user)
        booking = result.value!
        expect(result).to be_success
        expect(booking.status).to eq("return_the_deposit")
      end
    end

    context "when status 'completed'" do
      it "returns success with updated booking" do
        user = create(:user)
        car_park = create(:car_park)
        car = create(:car, owner: car_park)
        offer = create(:offer, car: car)
        booking = create(:booking, :return_the_deposit, car: car, offer: offer)

        status = "completed"

        result = described_class.new.call(booking, status, user)
        booking = result.value!
        expect(result).to be_success
        expect(booking.status).to eq("completed")
      end
    end

    context "when status 'canceled'" do
      it "returns success with updated booking" do
        user = create(:user)
        car_park = create(:car_park)
        car = create(:car, owner: car_park)
        offer = create(:offer, car: car)
        booking = create(:booking, :confirmed, car: car, offer: offer)

        status = "cancelled"

        result = described_class.new.call(booking, status, user)
        booking = result.value!
        expect(result).to be_success
        expect(booking.status).to eq("cancelled")
      end
    end
  end
end
