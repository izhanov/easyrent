# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Office::Bookings::Create do
  describe "#call" do
    context "when params are invalid" do
      it "returns failure with errors" do
        user = create(:user)

        params = {
          car_id: nil,
          offer_id: nil,
          client_id: nil,
          starts_at: Time.current + 1.day,
          ends_at: Time.current + 3.days,
          pickup_location: "office",
          drop_off_location: "office"
        }

        result = described_class.new.call(params, user)
        expect(result).to be_failure
        expect(result.failure).to match_array(
          [
            :validation_error,
            {
              car_id: ["is missing"],
              offer_id: ["is missing"],
              client_id: ["is missing"],
              payment_method: ["is missing"]
            }
          ]
        )
      end
    end

    context "when car is not vacant" do
      it "returns failure with car_is_not_vacant error" do
        user = create(:user)
        car_park = create(:car_park, user: user)
        car = create(:car, owner: car_park)
        offer = create(:offer, car: car)
        client_1 = create(:client)
        booking = create(
          :booking,
          car: car,
          offer: offer,
          client: client_1,
          starts_at: Time.current + 1.day,
          ends_at: Time.current + 3.days
        )

        client_2 = create(:client, identification_number: "901221300000", phone: "+77013670547")

        params = {
          car_id: car.id,
          offer_id: offer.id,
          client_id: client_2.id,
          starts_at: booking.starts_at + 1.day,
          ends_at: booking.ends_at + 4.days,
          pickup_location: "office",
          drop_off_location: "office",
          payment_method: "cash"
        }

        result = described_class.new.call(params, user)
        expect(result).to be_failure
        expect(result.failure).to match_array(
          [
            :car_is_not_vacant,
            {
              booking: ["Car in not vacant. Booked: #{booking.starts_at.strftime("%d/%m/%Y")} - #{booking.ends_at.strftime("%d/%m/%Y")}"]
            }
          ]
        )
      end
    end

    context "when params are valid" do
      it "creates booking" do
        user = create(:user)
        car_park = create(:car_park, user: user)
        car = create(:car, owner: car_park)
        mileage_limit = create(:rental_rule_mileage_limit, owner: car_park)
        offer = create(:offer, car: car, mileage_limit_id: mileage_limit.id)
        client = create(:client)

        params = {
          car_id: car.id,
          offer_id: offer.id,
          client_id: client.id,
          starts_at: Time.current + 1.day,
          ends_at: Time.current + 3.days,
          pickup_location: "office",
          drop_off_location: "office",
          payment_method: "cash",
          comments_attributes: {
            "0": {
              content: "Some comment"
            }
          }
        }

        result = described_class.new.call(params, user)
        booking = result.value!
        expect(result).to be_success
        expect(booking).to be_a(Booking)
      end

      it "change car status to `booked`" do
        user = create(:user)
        car_park = create(:car_park, user: user)
        mileage_limit = create(:rental_rule_mileage_limit, owner: car_park)
        car = create(:car, owner: car_park)
        offer = create(:offer, car: car, mileage_limit_id: mileage_limit.id)
        client = create(:client)

        params = {
          car_id: car.id,
          offer_id: offer.id,
          client_id: client.id,
          starts_at: Time.current + 1.day,
          ends_at: Time.current + 3.days,
          pickup_location: "office",
          drop_off_location: "office",
          payment_method: "cash",
          comments_attributes: {
            "0": {
              content: "Some comment"
            }
          }
        }

        result = subject.call(params, user)
        booking = result.value!
        car = booking.car

        expect(car.status).to eq("booked")
      end
    end
  end
end
