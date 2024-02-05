# frozen_string_literal: true

require "rails_helper"

RSpec.describe Validations::Office::Offers::Update do
  it "requires title, prices" do
    result = subject.call({})
    expect(result).to be_failure
    expect(result.errors.to_h).to include(
      {
        title: ["is missing"],
        prices: ["is missing"]
      }
    )
  end
end
