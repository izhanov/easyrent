# frozen_string_literal: true

require "rails_helper"

RSpec.describe Validations::Office::Offers::Update do
  it "requires car_id" do
    result = subject.call({})
    expect(result).to be_failure
    expect(result.errors.to_h).to include(
      {
        car_id: ["is missing"]
      }
    )
  end

  it "requires title" do
    result = subject.call({})
    expect(result).to be_failure
    expect(result.errors.to_h).to include(
      {
        title: ["is missing"]
      }
    )
  end

  it "requires prices" do
    result = subject.call({})
    expect(result).to be_failure
    expect(result.errors.to_h).to include(
      {
        prices: ["is missing"]
      }
    )
  end

  it "requires services" do
    result = subject.call({})
    expect(result).to be_failure
    expect(result.errors.to_h).to include(
      {
        services: ["is missing"]
      }
    )
  end
end
