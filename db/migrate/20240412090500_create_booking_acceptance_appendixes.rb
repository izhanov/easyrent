class CreateBookingAcceptanceAppendixes < ActiveRecord::Migration[7.1]
  def change
    create_table :booking_acceptance_appendixes do |t|
      t.references :booking, null: false, index: {unique: true}, foreign_key: true
      t.integer :mileage_after_rent
      t.integer :fuel_level_after_rent
      t.decimal :car_wash_amount, null: false, default: 0.0, precision: 10, scale: 2
      t.decimal :fine_amount, null: false, default: 0.0, precision: 10, scale: 2
      t.decimal :return_from_address_amount, null: false, default: 0.0, precision: 10, scale: 2

      t.timestamps
    end
  end
end
