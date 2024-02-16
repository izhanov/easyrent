class AddNumberColumnToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :number, :string
  end
end
