class CreateCarInspections < ActiveRecord::Migration[7.1]
  def change
    create_table :car_inspections do |t|
      t.references :car, null: false, foreign_key: true
      t.date :start_at
      t.date :end_at


      t.timestamps
    end
  end
end
