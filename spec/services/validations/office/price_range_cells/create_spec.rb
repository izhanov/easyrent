# frozen_string_literal: true

require "rails_helper"

RSpec.describe Validations::Office::PriceRangeCells::DayUnit::Create do
  it "requires price_range_id" do
    price_range = create(:price_range, :owned_by_car_park, unit: "day")
    params = {
      price_range_id: nil,
      from: 1,
      to: 2
    }

    validation = described_class.new(price_range: price_range)
    result = validation.call(params)
    expect(result).to be_failure
    expect(result.errors.to_h).to include(
      {
        price_range_id: ["is missing"]
      }
    )
  end

  it "requires price_range_id to be integer" do
    price_range = create(:price_range, :owned_by_car_park, unit: "day")
    params = {
      price_range_id: "string",
      from: 1,
      to: 2
    }

    validation = described_class.new(price_range: price_range)
    result = validation.call(params)
    expect(result).to be_failure
    expect(result.errors.to_h).to include(
      {
        price_range_id: ["must be an integer"]
      }
    )
  end

  it "requires from" do
    price_range = create(:price_range, :owned_by_car_park, unit: "day")
    params = {
      price_range_id: price_range.id,
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

  it "requires from to be integer" do
    price_range = create(:price_range, :owned_by_car_park, unit: "day")
    params = {
      price_range_id: price_range.id,
      from: "string",
      to: 2
    }

    validation = described_class.new(price_range: price_range)
    result = validation.call(params)
    expect(result).to be_failure
    expect(result.errors.to_h).to include(
      {
        from: ["must be an integer"]
      }
    )
  end

  it "requires to" do
    price_range = create(:price_range, :owned_by_car_park, unit: "day")
    params = {
      price_range_id: price_range.id,
      from: 1,
      to: nil
    }

    validation = described_class.new(price_range: price_range)
    result = validation.call(params)
    expect(result).to be_failure
    expect(result.errors.to_h).to include(
      {
        to: ["is missing"]
      }
    )
  end

  it "requires 'to' to be integer" do
    price_range = create(:price_range, :owned_by_car_park, unit: "day")
    params = {
      price_range_id: price_range.id,
      from: 1,
      to: "string"
    }

    validation = described_class.new(price_range: price_range)
    result = validation.call(params)
    expect(result).to be_failure
    expect(result.errors.to_h).to include(
      {
        to: ["must be an integer"]
      }
    )
  end
end
