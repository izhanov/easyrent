class AddPrepaymentMethodToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :prepayment_method, :string
  end
end
