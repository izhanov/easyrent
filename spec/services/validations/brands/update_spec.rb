# frozen_string_literal: true

require "rails_helper"

RSpec.describe Validations::Brands::Update do
  it "requires title" do
    result = subject.call(params: {title: ""})
    expect(result.errors.to_h).to include(title: ["is missing"])
    expect(result.errors.to_h).to_not include(synonyms: ["is missing"])
  end

  it "optional synonyms" do
    result = subject.call({synonyms: []})
    expect(result.errors.to_h).to include(title: ["is missing"])
    expect(result.errors.to_h).to_not include(synonyms: ["is missing"])
  end

  it "requires synonyms to be an array with string" do
    result = subject.call({title: "Batcar", synonyms: [1, "2"]})
    expect(result.errors.to_h).to_not include(title: ["is missing"])
    expect(result.errors.to_h).to include(synonyms: {0 => ["must be a string"]})
  end
end
