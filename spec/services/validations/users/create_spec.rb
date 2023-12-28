# frozen_string_literal: true

require "rails_helper"

RSpec.describe Validations::Users::Create do
  it "requires first name, last name, email, phone, kind" do
    result = subject.call({})
    expect(result.errors.to_h).to(
      include(
        first_name: ["is missing"],
        last_name: ["is missing"],
        email: ["is missing"],
        phone: ["is missing"],
        kind: ["is missing"]
      )
    )
  end

  it "requires kind to be one of User::KINDS" do
    result = subject.call(kind: "invalid")
    expect(result.errors.to_h).to(
      include(kind: ["must be one of: S, M, L, XL"])
    )
  end
end
