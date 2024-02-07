# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Office::PriceRangeCells::Create do
  describe "#call" do
    context "when params are valid" do
      it "returns success with created price range cell" do
        price_range = create(:price_range, :owned_by_car_park, unit: "day")
        params = {
          price_range_id: price_range.id,
          from: 1,
          to: 2
        }

        result = subject.call(params)
        expect(result).to be_success
        expect(result.value!).to be_a(PriceRangeCell)
      end
    end

    context "when params are invalid" do
      context "when from & to params empty" do
        it "returns failure with validation errors" do
          price_range = create(:price_range, :owned_by_car_park, unit: "day")
          params = {
            price_range_id: price_range.id,
            from: nil,
            to: nil
          }

          result = subject.call(params)
          expect(result).to be_failure
          expect(result.failure).to match_array(
            [
              :validation_error,
              {
                from: ["is missing"],
                to: ["is missing"]
              }
            ]
          )
        end
      end

      context "when from & to value already exists in different price range cell" do
        it "returns failure with validation errors" do
          price_range = create(:price_range, :owned_by_car_park, unit: "day")
          create(:price_range_cell, price_range: price_range, from: 1, to: 2)
          params = {
            price_range_id: price_range.id,
            from: 1,
            to: 2
          }

          result = subject.call(params)
          expect(result).to be_failure
          expect(result.failure).to match_array(
            [
              :validation_error,
              {
                price_range: {
                  price_range_cell: ["from cannot be less than last to", "from value already exist in range"]
                }
              }
            ]
          )
        end
      end

      context "when 'from' value current cell equal to 'to' value of previous cell" do
        it "returns failure with validation errors" do
          price_range = create(:price_range, :owned_by_car_park, unit: "day")
          create(:price_range_cell, price_range: price_range, from: 1, to: 2)
          params = {
            price_range_id: price_range.id,
            from: 2,
            to: 3
          }

          result = subject.call(params)
          expect(result).to be_failure
          expect(result.failure).to match_array(
            [
              :validation_error,
              {
                price_range: {
                  price_range_cell: ["from cannot be equal to last to"]
                }
              }
            ]
          )
        end
      end

      context "when 'from' value current cell less than 'to' value of previous cell" do
        it "returns failure with validation errors" do
          price_range = create(:price_range, :owned_by_car_park, unit: "day")
          create(:price_range_cell, price_range: price_range, from: 1, to: 2)
          params = {
            price_range_id: price_range.id,
            from: 0,
            to: 1
          }

          result = subject.call(params)
          expect(result).to be_failure
          expect(result.failure).to match_array(
            [
              :validation_error,
              {
                price_range: {
                  price_range_cell: ["from cannot be less than last to"]
                }
              }
            ]
          )
        end
      end

      context "when total days of price range cells greater than 30" do
        it "returns failure with validation errors" do
          price_range = create(:price_range, :owned_by_car_park, unit: "day")
          create(:price_range_cell, price_range: price_range, from: 1, to: 10)
          create(:price_range_cell, price_range: price_range, from: 11, to: 20)
          create(:price_range_cell, price_range: price_range, from: 21, to: 30)
          params = {
            price_range_id: price_range.id,
            from: 31,
            to: 40
          }

          result = subject.call(params)
          expect(result).to be_failure
          expect(result.failure).to match_array(
            [
              :validation_error,
              {
                price_range: {
                  price_range_cell: ["total days cannot be greater than 30"]
                }
              }
            ]
          )
        end
      end
    end
  end
end
