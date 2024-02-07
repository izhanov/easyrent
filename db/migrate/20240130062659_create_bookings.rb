class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.references :car, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
      t.references :offer, null: false, foreign_key: true
      t.datetime :starts_at, null: false
      t.datetime :ends_at, null: false
      t.datetime :actual_starts_at
      t.datetime :actual_ends_at
      t.string :pickup_location, null: false
      t.string :drop_off_location, null: false
      t.boolean :self_pickup, default: false
      t.boolean :self_drop_off, default: false

      t.timestamps
    end

    add_index :bookings, :starts_at, using: :brin
    add_index :bookings, :ends_at, using: :brin
  end
end
