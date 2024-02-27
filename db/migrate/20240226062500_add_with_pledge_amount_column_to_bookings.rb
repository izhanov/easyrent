class AddWithPledgeAmountColumnToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :with_pledge_amount, :boolean, default: false, null: false
  end
end
