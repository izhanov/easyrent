# frozen_string_literal: true

RSpec.describe Operations::Office::RentalRules::MileageLimits::Destroy do
  describe "#call" do
    context "when mileage limit exists" do
      it "destroys mileage limit" do
        mileage_limit = create(:rental_rule_mileage_limit, :owned_by_car_park)
        operation = described_class.new

        expect { operation.call(mileage_limit) }
          .to change { RentalRule::MileageLimit.count }.by(-1)
      end

      it "returns success" do
        mileage_limit = create(:rental_rule_mileage_limit, :owned_by_car_park)
        operation = described_class.new

        result = operation.call(mileage_limit)

        expect(result).to be_success
      end
    end
  end
end
