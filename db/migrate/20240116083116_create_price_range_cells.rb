class CreatePriceRangeCells < ActiveRecord::Migration[7.1]
  def change
    create_table :price_range_cells do |t|
      t.references :price_range, null: false, foreign_key: true
      t.integer :from, null: false
      t.integer :to, null: false

      t.timestamps
    end
  end
end
