class ChangeBookingsStatusDefaulValue < ActiveRecord::Migration[7.1]
  def change
    change_column_default :bookings, :status, from: 'new', to: 'initial'
  end
end
