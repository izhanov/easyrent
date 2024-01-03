# frozen_string_literal: true

require "rails_helper"

RSpec.describe Validations::Admins::Cities::Create do
  it "requires title" do
    result = subject.call({})

    expect(result.errors.to_h).to include(title: ["is missing"])
  end

  it "optional slug" do
    result = subject.call({})

    expect(result.errors.to_h).not_to include(slug: ["is missing"])
  end
end
