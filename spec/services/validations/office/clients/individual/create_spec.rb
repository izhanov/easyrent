# frozen_string_literal: true

require "rails_helper"

RSpec.describe Validations::Office::Clients::Individual::Create do
  it "requires name, surname, identification_number, phone, kind, citizen" do
    result = subject.call({})

    expect(result).to be_failure
    expect(result.errors.to_h).to include(
      name: ["is missing"],
      surname: ["is missing"],
      identification_number: ["is missing"],
      phone: ["is missing"],
      kind: ["is missing"],
      citizen: ["is missing"]
    )
  end

  it "requires driving_license, driving_license_issued_date" do
    result = subject.call({})

    expect(result).to be_failure
    expect(result.errors.to_h).to include(
      driving_license: ["is missing"],
      driving_license_issued_date: ["is missing"],
    )
  end

  it "requires bank_account_number to be in valid format" do
    result = subject.call(bank_account_number: "1234")

    expect(result).to be_failure
    expect(result.errors.to_h).to include(
      bank_account_number: ["must be in correct format"]
    )
  end

  it "requires driving_license_issued_date must be a date" do
    result = subject.call(driving_license_issued_date: "invalid date")

    expect(result).to be_failure
    expect(result.errors.to_h).to include(
      driving_license_issued_date: ["must be a date"]
    )
  end
end
