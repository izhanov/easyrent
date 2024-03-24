class AddOverMileagePriceToCars < ActiveRecord::Migration[7.1]
  def change
    add_column :cars, :over_mileage_price, :decimal, precision: 10, scale: 2
  end
end
