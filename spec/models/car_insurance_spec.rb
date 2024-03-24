# frozen_string_literal: true

require "rails_helper"

RSpec.describe CarInsurance, type: :model do
  it do
    is_expected.to have_db_column(:car_id).of_type(:integer)
    is_expected.to have_db_column(:start_at).of_type(:date)
    is_expected.to have_db_column(:end_at).of_type(:date)
  end

  describe "Associations" do
    it { is_expected.to belong_to(:car) }
  end

  describe "KINDS" do
    it "returns array of kinds" do
      expect(CarInsurance::KINDS).to(
        eq(
          %w[
            ogpo
            kasko
          ]
        )
      )
    end
  end
end
