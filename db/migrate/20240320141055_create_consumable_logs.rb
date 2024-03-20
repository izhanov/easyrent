class CreateConsumableLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :consumable_logs do |t|
      t.references :consumable, null: false, foreign_key: true
      t.date :date
      t.integer :mileage_when_replacing
      t.integer :mileage_at_next_replacing
      t.string :description

      t.timestamps
    end
  end
end
