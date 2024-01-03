# frozen_string_literal: true

require "rails_helper"

RSpec.describe Validations::Admins::Marks::Create do
  it "requires title, body" do
    result = subject.call(params: {title: ""})
    expect(result.errors.to_h).to include(title: ["is missing"], body: ["is missing"])
  end
end
