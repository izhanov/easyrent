# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Office::Comments::Create do
  describe "#call" do
    context "when params are invalid" do
      it "returns failure with errors" do
        params = {
          commentable_id: nil,
          commentable_type: nil,
          content: nil
        }

        result = described_class.new.call(params, nil)
        expect(result).to be_failure
        expect(result.failure).to match_array(
          [
            :validation_error,
            {
              commentable_id: ["is missing"],
              commentable_type: ["is missing"],
              content: ["is missing"]
            }
          ]
        )
      end
    end

    context "when params are valid" do
      it "creates a comment" do
        user = create(:user)
        car_park = create(:car_park)
        car = create(:car, owner: car_park)
        offer = create(:offer, car: car)
        booking = create(:booking, car: car, offer: offer)

        params = {
          commentable_id: booking.id,
          commentable_type: "Booking",
          content: "This is a comment"
        }

        result = described_class.new.call(params, user)
        comment = result.value!
        expect(result).to be_success
        expect(comment).to be_a(Comment)
        expect(comment.commentable_id).to eq(booking.id)
        expect(comment.commentable_type).to eq("Booking")
        expect(comment.content).to eq("This is a comment")
      end
    end
  end
end
