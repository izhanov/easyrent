require "rails_helper"

RSpec.describe Mark, type: :model do
  it do
    is_expected.to(
      have_db_column(:title).of_type(:string).with_options(null: false)
    )
  end

  describe "Associations" do
    it { is_expected.to belong_to(:brand) }
  end

  describe "BODY_TYPES" do
    it "returns array of body types" do
      expect(Mark::BODY_TYPES).to eq(
        %w[
          sedan
          hatchback
          universal
          coupe
          convertible
          suv
          pickup
          minivan
          van
          limousine
          crossover
          roadster
          truck
          bus
          other
        ]
      )
    end
  end
end
