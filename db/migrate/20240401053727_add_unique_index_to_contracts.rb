class AddUniqueIndexToContracts < ActiveRecord::Migration[7.1]
  def change
    add_index :contracts, [:booking_id, :number], unique: true
  end
end
