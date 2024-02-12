class AddServicesColumnToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :services, :jsonb, default: {}
  end
end
