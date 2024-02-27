class AddPledgeAmountToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :pledge_amount, :decimal, default: 0.0, null: false, precision: 10, scale: 2
  end
end
