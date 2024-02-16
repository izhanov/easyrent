class AddBookingPrefixColumnToCarParks < ActiveRecord::Migration[7.1]
  def change
    add_column :car_parks, :booking_prefix, :string, limit: 4, null: false, default: "UNDF"
    add_index :car_parks, :booking_prefix, unique: true, where: "booking_prefix IS NOT NULL"
  end
end
