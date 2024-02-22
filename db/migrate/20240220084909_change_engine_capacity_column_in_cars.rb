class ChangeEngineCapacityColumnInCars < ActiveRecord::Migration[7.1]
  def up
    change_column :cars, :engine_capacity, :decimal, precision: 7, scale: 2
  end

  def down
    change_column :cars, :engine_capacity, :integer
  end
end
