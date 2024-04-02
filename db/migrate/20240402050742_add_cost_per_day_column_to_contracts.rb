class AddCostPerDayColumnToContracts < ActiveRecord::Migration[7.1]
  def change
    add_column :contracts, :cost_per_day, :decimal, default: 0.0, precision: 10, scale: 2
  end
end
