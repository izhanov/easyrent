class AddWithoutPrepaymentAmountToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :without_prepayment_amount, :boolean
  end
end
