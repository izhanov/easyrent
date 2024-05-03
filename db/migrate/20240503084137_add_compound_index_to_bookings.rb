class AddCompoundIndexToBookings < ActiveRecord::Migration[7.1]
  def change
    add_index :bookings, %i[car_id status starts_at ends_at], name: "index_bookings_on_car_id_and_status_and_starts_at_and_ends_at"
  end
end
