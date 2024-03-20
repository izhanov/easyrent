class CreateConsumables < ActiveRecord::Migration[7.1]
  def change
    create_table :consumables do |t|
      t.references :car, null: false, foreign_key: true
      t.string :title
      t.string :description
      t.integer :lifetime

      t.timestamps
    end
  end
end
