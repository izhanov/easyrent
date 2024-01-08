class CreateCars < ActiveRecord::Migration[7.1]
  def change
    create_table :cars do |t|
      t.references :mark, null: false, foreign_key: true
      t.references :ownerable, polymorphic: true, null: false

      t.string :year
      t.string :vin_code, null: false
      t.string :plate_number, null: false
      t.string :klass
      t.string :technical_certificate_number
      t.string :mileage
      t.string :fuel
      t.string :color
      t.string :transmission
      t.string :status
      t.string :number_of_seats
      t.string :tank_volume

      t.timestamps
    end
  end
end
