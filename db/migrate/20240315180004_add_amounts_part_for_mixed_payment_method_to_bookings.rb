class AddAmountsPartForMixedPaymentMethodToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :kaspi_method_amount, :decimal, precision: 10, scale: 2, default: 0.0, null: false
    add_column :bookings, :halyk_method_amount, :decimal, precision: 10, scale: 2, default: 0.0, null: false
    add_column :bookings, :cash_method_amount, :decimal, precision: 10, scale: 2, default: 0.0, null: false
  end
end
