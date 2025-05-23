# frozen_string_literal: true

require "rails_helper"

RSpec.describe Validations::Office::RentalRules::MileageLimits::Create do
  it "requires title" do
    result = subject.call({})
    expect(result).to be_failure
    expect(result.errors.to_h).to include(
      {
        title: ["is missing"]
      }
    )
  end

  it "requires value" do
    result = subject.call({})
    expect(result).to be_failure
    expect(result.errors.to_h).to include(
      {
        value: ["is missing"]
      }
    )
  end

  it "requires value to be integer" do
    result = subject.call({value: "string"})
    expect(result).to be_failure
    expect(result.errors.to_h).to include(
      {
        value: ["must be an integer"]
      }
    )
  end

  it "requires value to be greater than 0" do
    result = subject.call({value: -1})
    expect(result).to be_failure
    expect(result.errors.to_h).to include(
      {
        value: ["must be greater than 0"]
      }
    )
  end

  it "requires owner_id" do
    result = subject.call({})
    expect(result).to be_failure
    expect(result.errors.to_h).to include(
      {
        owner_id: ["is missing"]
      }
    )
  end

  it "requires owner_type" do
    result = subject.call({})
    expect(result).to be_failure
    expect(result.errors.to_h).to include(
      {
        owner_type: ["is missing"]
      }
    )
  end

  it "requires owner_type to be string" do
    result = subject.call({owner_type: 1})
    expect(result).to be_failure
    expect(result.errors.to_h).to include(
      {
        owner_type: ["must be a string"]
      }
    )
  end

  it "optional markup" do
    result = subject.call({})
    expect(result).to be_failure
    expect(result.errors.to_h).to_not include(
      {
        markup: ["is missing"]
      }
    )
  end

  it "requires markup to be integer" do
    result = subject.call({markup: "string"})
    expect(result).to be_failure
    expect(result.errors.to_h).to include(
      {
        markup: ["must be an integer"]
      }
    )
  end

  it "optional discount" do
    result = subject.call({})
    expect(result).to be_failure
    expect(result.errors.to_h).to_not include(
      {
        discount: ["is missing"]
      }
    )
  end

  it "requires discount to be integer" do
    result = subject.call({discount: "string"})
    expect(result).to be_failure
    expect(result.errors.to_h).to include(
      {
        discount: ["must be an integer"]
      }
    )
  end
end
