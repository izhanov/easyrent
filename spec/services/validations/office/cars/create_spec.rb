# frozen_string_literal: true

require "rails_helper"

RSpec.describe Validations::Office::Cars::Create do
  it "requires ownerable_id and ownerable_type" do
    result = subject.call({mark_id: 1, plate_number: "666BOP02"})
    expect(result.errors.to_h).to include(ownerable_id: ["is missing"], ownerable_type: ["is missing"])
  end

  it "requires mark_id" do
    result = subject.call({ownerable_id: 1, ownerable_type: "User", plate_number: "666BOP02"})
    expect(result.errors.to_h).to include(mark_id: ["is missing"])
  end

  it "requires plate_number" do
    result = subject.call({ownerable_id: 1, ownerable_type: "User", mark_id: 1})
    expect(result.errors.to_h).to include(plate_number: ["is missing"])
  end

  it "requires year" do
    result = subject.call({ownerable_id: 1, ownerable_type: "User", mark_id: 1, plate_number: "666BOP02"})
    expect(result.errors.to_h).to include(year: ["is missing"])
  end

  it "requires fuel" do
    result = subject.call({ownerable_id: 1, ownerable_type: "User", mark_id: 1, plate_number: "666BOP02", year: "2023"})
    expect(result.errors.to_h).to include(fuel: ["is missing"])
  end

  it "requires fuel must be included in Car::FUEL_TYPES" do
    result = subject.call({ownerable_id: 1, ownerable_type: "User", mark_id: 1, plate_number: "666BOP02", year: "2023", fuel: "invalid"})
    expect(result.errors.to_h).to include(fuel: ["must be one of: #{Car::FUEL_TYPES.join(", ")}"])
  end

  it "requires klass" do
    result = subject.call({ownerable_id: 1, ownerable_type: "User", mark_id: 1, plate_number: "666BOP02", year: "2023", fuel: "gasoline"})
    expect(result.errors.to_h).to include(klass: ["is missing"])
  end

  it "requires klass must be included in Car::KLASS_TYPES" do
    result = subject.call({ownerable_id: 1, ownerable_type: "User", mark_id: 1, plate_number: "666BOP02", year: "2023", fuel: "gasoline", klass: "invalid"})
    expect(result.errors.to_h).to include(klass: ["must be one of: #{Car::KLASS_TYPES.join(", ")}"])
  end

  it "requires transmission" do
    result = subject.call({ownerable_id: 1, ownerable_type: "User", mark_id: 1, plate_number: "666BOP02", year: "2023", fuel: "gasoline", klass: "economy"})
    expect(result.errors.to_h).to include(transmission: ["is missing"])
  end

  it "requires transmission must be included in Car::TRANSMISSION_TYPES" do
    result = subject.call({ownerable_id: 1, ownerable_type: "User", mark_id: 1, plate_number: "666BOP02", year: "2023", fuel: "gasoline", klass: "economy", transmission: "invalid"})
    expect(result.errors.to_h).to include(transmission: ["must be one of: #{Car::TRANSMISSION_TYPES.join(", ")}"])
  end

  it "requires vin_code" do
    result = subject.call({ownerable_id: 1, ownerable_type: "User", mark_id: 1, plate_number: "666BOP02", year: "2023", fuel: "gasoline", klass: "economy", transmission: "automatic"})
    expect(result.errors.to_h).to include(vin_code: ["is missing"])
  end

  it "requires technical_certificate_number" do
    result = subject.call({ownerable_id: 1, ownerable_type: "User", mark_id: 1, plate_number: "666BOP02", year: "2023", fuel: "gasoline", klass: "economy", transmission: "automatic", vin_code: "1234567890"})
    expect(result.errors.to_h).to include(technical_certificate_number: ["is missing"])
  end

  it "requires mileage" do
    result = subject.call({ownerable_id: 1, ownerable_type: "User", mark_id: 1, plate_number: "666BOP02", year: "2023", fuel: "gasoline", klass: "economy", transmission: "automatic", vin_code: "1234567890", technical_certificate_number: "1234567890"})
    expect(result.errors.to_h).to include(mileage: ["is missing"])
  end

  it "requires color" do
    result = subject.call({ownerable_id: 1, ownerable_type: "User", mark_id: 1, plate_number: "666BOP02", year: "2023", fuel: "gasoline", klass: "economy", transmission: "automatic", vin_code: "1234567890", technical_certificate_number: "1234567890", mileage: "1234567890"})
    expect(result.errors.to_h).to include(color: ["is missing"])
  end

  it "requires number_of_seats" do
    result = subject.call({ownerable_id: 1, ownerable_type: "User", mark_id: 1, plate_number: "666BOP02", year: "2023", fuel: "gasoline", klass: "economy", transmission: "automatic", vin_code: "1234567890", technical_certificate_number: "1234567890", mileage: "1234567890", color: "red"})
    expect(result.errors.to_h).to include(number_of_seats: ["is missing"])
  end

  it "requires engine_capacity and engine_capacity_unit" do
    result = subject.call({ownerable_id: 1, ownerable_type: "User", mark_id: 1, plate_number: "666BOP02", year: "2023", fuel: "gasoline", klass: "economy", transmission: "automatic", vin_code: "1234567890", technical_certificate_number: "1234567890", mileage: "1234567890", color: "red", number_of_seats: "5"})
    expect(result.errors.to_h).to include(engine_capacity: ["is missing"], engine_capacity_unit: ["is missing"])
  end

  it "requires engine_capacity_unit must be included in Car::ENGINE_CAPACITY_UNITS" do
    result = subject.call({ownerable_id: 1, ownerable_type: "User", mark_id: 1, plate_number: "666BOP02", engine_capacity: "1.6", year: "2023", fuel: "gasoline", klass: "economy", transmission: "automatic", vin_code: "1234567890", technical_certificate_number: "1234567890", mileage: "1234567890", color: "red", number_of_seats: "5", engine_capacity_unit: "invalid"})
    expect(result.errors.to_h).to include(engine_capacity_unit: ["must be one of: #{Car::ENGINE_CAPACITY_UNITS.join(", ")}"])
  end
end
