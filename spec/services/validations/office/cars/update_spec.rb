# frozen_string_literal: true

require "rails_helper"

RSpec.describe Validations::Office::Cars::Update do
  it "requires plate_number, vin_code, technical_certificate_number" do
    result = subject.call({})
    expect(result.errors.to_h).to include(
      {
        plate_number: ["is missing"],
        vin_code: ["is missing"],
        technical_certificate_number: ["is missing"]
      }
    )
  end

  it "requires year, color, engine_capacity, engine_capaicty_unit" do
    result = subject.call({})
    expect(result.errors.to_h).to include(
      {
        year: ["is missing"],
        color: ["is missing"],
        engine_capacity: ["is missing"],
        engine_capacity_unit: ["is missing"]
      }
    )
  end

  it "requires fuel, tank_volume, number_of_seats, mileage" do
    result = subject.call({})
    expect(result.errors.to_h).to include(
      {
        fuel: ["is missing"],
        tank_volume: ["is missing"],
        number_of_seats: ["is missing"],
        mileage: ["is missing"]
      }
    )
  end
end
