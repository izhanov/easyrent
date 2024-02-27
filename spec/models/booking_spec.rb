require "rails_helper"

RSpec.describe Booking, type: :model do
  it do
    is_expected.to have_db_column(:car_id).of_type(:integer).with_options(null: false)
    is_expected.to have_db_column(:client_id).of_type(:integer).with_options(null: false)
    is_expected.to have_db_column(:offer_id).of_type(:integer).with_options(null: false)
    is_expected.to have_db_column(:starts_at).of_type(:datetime).with_options(null: false)
    is_expected.to have_db_column(:ends_at).of_type(:datetime).with_options(null: false)
    is_expected.to have_db_column(:status).of_type(:string).with_options(null: false)
    is_expected.to have_db_column(:services).of_type(:jsonb)
    is_expected.to have_db_column(:pickup_location).of_type(:string).with_options(null: false)
    is_expected.to have_db_column(:drop_off_location).of_type(:string).with_options(null: false)
    is_expected.to have_db_column(:self_pickup).of_type(:boolean)
    is_expected.to have_db_column(:self_drop_off).of_type(:boolean)
    is_expected.to have_db_column(:actual_starts_at).of_type(:datetime)
    is_expected.to have_db_column(:actual_ends_at).of_type(:datetime)
    is_expected.to have_db_column(:payment_method).of_type(:string)
    is_expected.to have_db_column(:pledge_amount).of_type(:decimal).with_options(precision: 10, scale: 2)
    is_expected.to have_db_column(:with_pledge_amount).of_type(:boolean).with_options(default: false)
  end

  describe "Associations" do
    it { is_expected.to belong_to(:car) }
    it { is_expected.to belong_to(:client) }
    it { is_expected.to belong_to(:offer) }
  end

  describe "Booking::PAYMENT_METHODS" do
    it "returns array of payment methods" do
      expect(Booking::PAYMENT_METHODS).to eq(%w[cash cashless])
    end
  end

  describe "Booking::STATUSES" do
    it "returns array of statuses" do
      expect(Booking::STATUSES).to eq(
        %w[
          new
          confirmed
          payment_accepted
          give_out_the_car
          car_in_rent
          accept_the_car
          return_the_deposit
          canceled
          finished
        ]
      )
    end
  end
end
