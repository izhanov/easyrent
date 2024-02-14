# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Office::Clients::Accession do
  describe "#call" do
    context "when client exists" do
      it "returns succes with existing client" do
        client = create(:client, identification_number: "901221300000", phone: "+77013670547")
        car_park = create(:car_park)
        params = {
          identification_number: "901221300000",
          phone: "+77013670547"
        }

        result = described_class.new.call(car_park, params)
        value = result.value!
        expect(result).to be_success
        expect(value).to be_a(Client)
        expect(value.id).to eq(client.id)
        expect(value.identification_number).to eq(client.identification_number)
        expect(value.phone).to eq(client.phone)
      end
    end

    context "when client does not exist" do
      it "creates client and returns success with created client" do
        car_park = create(:car_park)
        params = {
          identification_number: "901221300000",
          phone: "+77013670547",
          name: "John",
          surname: "Doe",
          email: "birbir@mail.com",
          kind: "individual",
          citizen: true,
          driving_license: "1234567890",
          driving_license_issued_date: "2020-01-01",
          bank_account_number: "KZ123456789087654321"
        }

        result = described_class.new.call(car_park, params)
        value = result.value!
        expect(result).to be_success
        expect(value).to be_a(Client)
      end
    end
  end
end
