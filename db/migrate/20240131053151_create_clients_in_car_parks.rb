class CreateClientsInCarParks < ActiveRecord::Migration[7.1]
  def change
    create_table :clients_in_car_parks do |t|
      t.references :client, null: false, foreign_key: true
      t.references :car_park, null: false, foreign_key: true

      t.timestamps
    end
  end
end
