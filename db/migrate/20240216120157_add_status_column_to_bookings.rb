class AddStatusColumnToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :status, :string, null: false, default: "new"
  end
end
