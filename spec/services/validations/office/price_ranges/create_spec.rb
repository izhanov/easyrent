# frozen_string_literal: true

require "rails_helper"

RSpec.describe Validations::Office::PriceRanges::Create do
  it "requires owner_id" do
    params = {
      owner_id: nil,
      owner_type: "CarPark",
      unit: "day"
    }

    result = subject.call(params)
    expect(result).to be_failure
    expect(result.errors.to_h).to include(
      {
        owner_id: ["is missing"]
      }
    )
  end

  it "requires owner_id to be integer" do
    params = {
      owner_id: "string",
      owner_type: "CarPark",
      unit: "day"
    }

    result = subject.call(params)
    expect(result).to be_failure
    expect(result.errors.to_h).to include(
      {
        owner_id: ["must be an integer"]
      }
    )
  end

  it "requires owner_type" do
    params = {
      owner_id: 1,
      owner_type: nil,
      unit: "day"
    }

    result = subject.call(params)
    expect(result).to be_failure
    expect(result.errors.to_h).to include(
      {
        owner_type: ["is missing"]
      }
    )
  end

  it "requires unit" do
    params = {
      owner_id: 1,
      owner_type: "CarPark",
      unit: nil
    }

    result = subject.call(params)
    expect(result).to be_failure
    expect(result.errors.to_h).to include(
      {
        unit: ["is missing"]
      }
    )
  end
end
