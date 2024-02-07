# frozen_string_literal: true

require "rails_helper"

RSpec.describe Validations::Admins::Users::Update do
  it "requires first name last name and kind" do
    result = subject.call({})
    expect(result.errors.to_h).to(
      include(
        first_name: ["is missing"],
        last_name: ["is missing"],
        kind: ["is missing"]
      )
    )
  end

  it "requires kind to be included in User::KINDS" do
    result = subject.call({kind: "invalid"})
    expect(result.errors.to_h).to include(kind: ["must be one of: s, m, l, xl"])
  end
end
