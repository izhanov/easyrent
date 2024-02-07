# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Office::Clients::Create do
  describe "#call" do
    context "with invalid params" do
      context "when identification number is not unique" do
        it "returns failure with uniqueness violation error" do
          client = create(:client)
          params = {
            identification_number: client.identification_number,
            name: "John",
            surname: "Doe",
            phone: "+77002571210",
            citizen: true,
            kind: "individual",
            driving_license: "BK 82353",
            driving_license_issued_date: "2018-01-01",
            email: "johndoe@mail.com",
            bank_account_number: "KZ123456789012345678"
          }

          result = described_class.new.call(params)

          expect(result).to be_failure
          expect(result.failure).to match_array(
            [
              :uniqueness_violation,
              {identification_or_phone_number: ["must be unique"]}
            ]
          )
        end
      end

      context "when phone is not unique" do
        it "returns failure with uniqueness violation error" do
          client = create(:client)
          params = {
            identification_number: "1234567890",
            name: "John",
            surname: "Doe",
            phone: client.phone,
            citizen: true,
            kind: "individual",
            driving_license: "BK 82353",
            driving_license_issued_date: "2018-01-01",
            email: "johndoe@mail.com",
            bank_account_number: "KZ123456789012345678"
          }

          result = described_class.new.call(params)

          expect(result).to be_failure
          expect(result.failure).to match_array(
            [
              :uniqueness_violation,
              {identification_or_phone_number: ["must be unique"]}
            ]
          )
        end
      end
    end
  end
end
