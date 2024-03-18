# frozen_string_literal: true

require "rails_helper"

RSpec.describe Validations::Office::Comments::Create do
  it "requires commentable_id, commentable_type, content" do
    result = subject.call({})
    expect(result).to be_failure
    expect(result.errors.to_h).to match_array(
      {
        commentable_id: ["is missing"],
        commentable_type: ["is missing"],
        content: ["is missing"]
      }
    )
  end
end
