class CreatePriceRanges < ActiveRecord::Migration[7.1]
  def change
    create_table :price_ranges do |t|
      t.references :car_park, null: false, foreign_key: true, index: {unique: true}
      t.string :unit, null: false

      t.timestamps
    end
  end
end
