# frozen_string_literal: true

require "rails_helper"

RSpec.describe Validations::Office::Clients::Legal::Create do
  it "requires name, identification_number, phone, kind, email, full_name_of_the_head" do
    result = subject.call({})

    expect(result).to be_failure
    expect(result.errors.to_h).to include(
      name: ["is missing"],
      identification_number: ["is missing"],
      phone: ["is missing"],
      kind: ["is missing"],
      email: ["is missing"],
      full_name_of_the_head: ["is missing"]
    )
  end

  it "requires legal_address, bank_code, bank_account_number" do
    result = subject.call({})

    expect(result).to be_failure
    expect(result.errors.to_h).to include(
      legal_address: ["is missing"],
      bank_code: ["is missing"],
      bank_account_number: ["is missing"]
    )
  end

  it "requires bank_account_number to be in valid format" do
    result = subject.call(bank_account_number: "1234")

    expect(result).to be_failure
    expect(result.errors.to_h).to include(
      bank_account_number: ["must be in correct format"]
    )
  end
end
