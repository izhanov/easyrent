# frozen_string_literal: true

require "rails_helper"

RSpec.describe Validations::Office::Offers::Create do
  it "requires car_id, title, prices" do
    result = subject.call({})
    expect(result).to be_failure
    expect(result.errors.to_h).to include(
      {
        car_id: ["is missing"],
        title: ["is missing"],
        prices: ["is missing"]
      }
    )
  end
end
