# frozen_strng_literal: true

require "rails_helper"

RSpec.describe Validations::Office::PriceRanges::Update do
  it "requires unit" do
    params = {
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

  it "requires unit to be one of: day" do
    params = {
      unit: "invalid"
    }

    result = subject.call(params)
    expect(result).to be_failure
    expect(result.errors.to_h).to include(
      {
        unit: ["must be one of: day"]
      }
    )
  end
end
