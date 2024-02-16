# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Office::CarParks::Create do
  describe "#call" do
    context "when kind is llp" do
      context "when params are valid" do
        it "returns success and creates car park" do
          user = create(:user)
          city = create(:city)

          params = {
            user_id: user.id,
            city_id: city.id,
            kind: "llp",
            title: "Title",
            business_id_number: "230140378261",
            legal_address: "Legal address",
            contact_phone: "+7(700)789-23-87",
            bank_name: "Bank name",
            bank_account_number: "KZ123456789012345678",
            email: Faker::Internet.email,
            bank_code: "ATYNKZKA",
            benificiary_code: "17",
            service_phone: "+7(700)789-23-87",
            booking_prefix: "NYC"
          }

          result = subject.call(params)
          expect(result).to be_success
          expect(result.value!).to be_a(CarPark)
        end

        it "normalizes phones and save they" do
          user = create(:user)
          city = create(:city)

          params = {
            user_id: user.id,
            city_id: city.id,
            kind: "llp",
            title: "Title",
            business_id_number: "230140378261",
            legal_address: "Legal address",
            contact_phone: "+7(700)789-23-87",
            bank_name: "Bank name",
            bank_account_number: "KZ123456789012345678",
            email: Faker::Internet.email,
            bank_code: "ATYNKZKA",
            benificiary_code: "17",
            service_phone: "+7(700)789-23-87",
            booking_prefix: "NYC"
          }

          result = subject.call(params)
          car_park = result.value!

          expect(car_park.contact_phone).to eq("+77007892387")
          expect(car_park.service_phone).to eq("+77007892387")
        end
      end

      context "when params are invalid" do
        it "returns failure and does not create car park" do
          user = create(:user)
          city = create(:city)
          params = {
            user_id: user.id,
            city_id: city.id,
            kind: "llp",
            title: "Title",
            business_id_number: nil,
            legal_address: "Legal address",
            contact_phone: "+7(700)78923-87",
            service_phone: ""
          }

          result = subject.call(params)
          expect(result).to be_failure
          expect(result.failure).to include(:validation_error)
        end
      end
    end

    context "when kind is ie" do
      context "when params are valid" do
        it "returns success and creates car park" do
          user = create(:user)
          city = create(:city)
          params = {
            user_id: user.id,
            city_id: city.id,
            kind: "ie",
            title: "Title",
            business_id_number: "230140378261",
            legal_address: "Legal address",
            contact_phone: "+7(700)789-23-87",
            bank_name: "Bank name",
            bank_account_number: "KZ123456789012345678",
            email: Faker::Internet.email,
            card_id_number: "123456789",
            privateer_number: "123456789",
            privateer_date: Date.today,
            residence_address: "Residence address",
            booking_prefix: "NYC"
          }

          result = subject.call(params)
          expect(result).to be_success
          expect(result.value!).to be_a(CarPark)
        end

        it "normalizes phones and save they" do
          user = create(:user)
          city = create(:city)

          params = {
            user_id: user.id,
            city_id: city.id,
            kind: "ie",
            title: "Title",
            business_id_number: "230140378261",
            legal_address: "Legal address",
            contact_phone: "+7(700)789-23-87",
            bank_name: "Bank name",
            bank_account_number: "KZ123456789012345678",
            email: Faker::Internet.email,
            card_id_number: "123456789",
            privateer_number: "123456789",
            privateer_date: Date.today,
            residence_address: "Residence address",
            booking_prefix: "NYC"
          }

          result = subject.call(params)
          car_park = result.value!

          expect(car_park.contact_phone).to eq("+77007892387")
          expect(car_park.service_phone).to eq(nil)
        end
      end

      context "when params are invalid" do
        it "returns failure and does not create car park" do
          user = create(:user)
          city = create(:city)
          params = {
            user_id: user.id,
            city_id: city.id,
            kind: "ie",
            title: "Title",
            business_id_number: nil,
            legal_address: "Legal address",
            contact_phone: "+7(700)78923-87",
            service_phone: ""
          }

          result = subject.call(params)
          expect(result).to be_failure
          expect(result.failure).to include(:validation_error)
          expect(result.failure.last).to include(business_id_number: ["is missing"])
        end
      end
    end
  end
end
