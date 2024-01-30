# frozen_string_literal: true

require "rails_helper"

RSpec.describe Validations::Office::RentalRules::DrivingExperiences::Update do
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
end
