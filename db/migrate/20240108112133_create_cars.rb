class CreateCars < ActiveRecord::Migration[7.1]
  def change
    create_table :cars do |t|
      t.references :mark, null: false, foreign_key: true
      t.references :owner, polymorphic: true, null: false

      t.integer :year, limit: 2, null: false
      t.string :vin_code, null: false
      t.string :plate_number, null: false
      t.string :klass, null: false
      t.string :technical_certificate_number, null: false
      t.integer :mileage
      t.string :fuel
      t.string :color
      t.string :transmission, null: false
      t.string :status, null: false, default: "vacant"
      t.integer :number_of_seats, limit: 2
      t.integer :tank_volume, limit: 2
      t.integer :engine_capacity, limit: 2
      t.string :engine_capacity_unit

      t.timestamps
    end

    add_index :cars, [:owner_id, :owner_type, :plate_number], unique: true
    add_index :cars, [:owner_id, :owner_type, :vin_code], unique: true
  end
end
