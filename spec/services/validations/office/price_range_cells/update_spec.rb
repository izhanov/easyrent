# frozen_string_literal: true

require "rails_helper"

RSpec.describe Validations::Office::PriceRangeCells::DayUnit::Update do
  it "requires from" do
    price_range = create(:price_range, :owned_by_car_park, unit: "day")
    params = {
      from: nil,
      to: 2
    }

    validation = described_class.new(price_range: price_range)
    result = validation.call(params)
    expect(result).to be_failure
    expect(result.errors.to_h).to include(
      {
        from: ["is missing"]
      }
    )
  end
end
