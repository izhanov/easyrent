# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Office::Clients::Update do
  describe "#call" do
    context "when kind is 'individual' and params are invalid" do
      it "returns failure with errors" do
        client = create(:client, :individual)
        params = {
          kind: "individual",
          name: nil,
          surname: "Doe",
          email: "joejoe@mail.com",
          driving_license: "1234567890",
          driving_license_issued_date: "2020-01-01",
          bank_account_number: "KZ123456789087654321",
          citizen: true
        }

        result = described_class.new.call(client, params)
        expect(result).to be_failure
        expect(result.failure).to match_array(
          [
            :validation_error,
            {
              name: ["is missing"],
              phone: ["is missing"]
            }
          ]
        )
      end
    end

    context "when kind is 'individual' params are valid" do
      it "updates client and returns success" do
        client = create(:client, :individual)
        params = {
          name: "Sam",
          surname: "Porter",
          email: client.email,
          driving_license: "1234567890",
          driving_license_issued_date: "2020-01-01",
          bank_account_number: "KZ123456789087654321",
          citizen: true,
          phone: client.phone
        }

        result = described_class.new.call(client, params)
        value = result.value!
        expect(result).to be_success
        expect(value).to be_a(Client)
        expect(value.name).to eq("Sam")
      end
    end

    context "when kind is 'legal' and params are invalid" do
      it "returns failure with errors" do
        client = create(:client, :legal)
        params = {
          kind: "legal",
          name: "Bridges Inc",
          full_name_of_the_head: client.full_name_of_the_head,
          email: client.email,
          bank_account_number: "KZ123456789087654324",
          legal_address: "Almaty, Kazakhstan",
          bank_code: "KZ123456",
          signed_on_basis: "John Doe",
          phone: nil
        }

        result = described_class.new.call(client, params)
        expect(result).to be_failure
        expect(result.failure).to match_array(
          [
            :validation_error,
            {phone: ["is missing"]}
          ]
        )
      end
    end

    context "when kind is 'legal' and params are valid" do
    end
  end
end
