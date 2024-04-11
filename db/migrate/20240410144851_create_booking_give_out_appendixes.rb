class CreateBookingGiveOutAppendixes < ActiveRecord::Migration[7.1]
  def change
    create_table :booking_give_out_appendixes do |t|
      t.references :booking, null: false, index: {unique: true}, foreign_key: true
      t.integer :mileage_before_rent
      t.integer :fuel_level_before_rent
      t.string :appearance_before_rent
      t.string :technical_condition_before_rent

      t.timestamps
    end
  end
end
