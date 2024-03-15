class AddPledgeMethodToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :pledge_method, :string
  end
end
