class CreateCarInsurances < ActiveRecord::Migration[7.1]
  def change
    create_table :car_insurances do |t|
      t.references :car, null: false, foreign_key: true
      t.date :start_at
      t.date :end_at
      t.string :kind

      t.timestamps
    end
  end
end
