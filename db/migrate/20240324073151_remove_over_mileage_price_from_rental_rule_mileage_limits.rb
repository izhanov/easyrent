class RemoveOverMileagePriceFromRentalRuleMileageLimits < ActiveRecord::Migration[7.1]
  def change
    remove_column :rental_rule_mileage_limits, :over_mileage_price, :decimal, precision: 7, scale: 2, null: false, default: 0.0
  end
end
