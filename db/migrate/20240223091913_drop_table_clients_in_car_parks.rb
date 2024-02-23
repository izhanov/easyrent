class DropTableClientsInCarParks < ActiveRecord::Migration[7.1]
  def change
    drop_table :clients_in_car_parks do |t|
      t.references :client, foreign_key: true, null: false
      t.references :car_park, foreign_key: true, null: false
      t.timestamps
    end
  end
end
