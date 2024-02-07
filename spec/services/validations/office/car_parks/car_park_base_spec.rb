# frozen_string_literal: true

require "rails_helper"

RSpec.describe Validations::Office::CarParks::CarParkBase do
  describe "#call" do
    it "requires user_id, city_id, title, business_id_number, kind" do
      expect(subject.call({}).errors.to_h).to(
        include(
          user_id: ["is missing"],
          city_id: ["is missing"],
          title: ["is missing"],
          business_id_number: ["is missing"],
          kind: ["is missing"]
        )
      )
    end

    it "requires bank account number to be in correct format" do
      expect(subject.call(bank_account_number: "123").errors.to_h).to(
        include(bank_account_number: ["must be in correct format"])
      )
      expect(subject.call(bank_account_number: "KZ123456789012345678").errors.to_h).not_to(
        include(bank_account_number: ["must be in correct format"])
      )
    end
  end
end
