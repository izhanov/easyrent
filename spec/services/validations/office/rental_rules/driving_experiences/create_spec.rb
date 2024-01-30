# frozen_string_literal: true

require "rails_helper"

RSpec.describe Validations::Office::RentalRules::DrivingExperiences::Create do
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
end
